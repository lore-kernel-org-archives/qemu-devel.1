Received: from eggs.gnu.org ([2001:4830:134:3::10]:42547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cosmT-0004xT-CQ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cosmO-000075-Ff
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:23:01 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cosmO-00006v-Bo
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:22:56 -0400
Received: by mail-qt0-x241.google.com with SMTP id r5so9654451qtb.2
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:22:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170317092802.17973-1-marcandre.lureau@redhat.com>
	<20170317101404.GC8050@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <71e89db4-f81c-d81f-b9e1-0f123b0b33d1@amsat.org>
Date: Fri, 17 Mar 2017 11:22:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170317101404.GC8050@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vnc: fix a qio-channel leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On 03/17/2017 07:14 AM, Daniel P. Berrange wrote:
> On Fri, Mar 17, 2017 at 01:28:02PM +0400, Marc-André Lureau wrote:
>> Spotted by ASAN.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  ui/vnc.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 8bfb1e0685..6e93b883b5 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -3677,6 +3677,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
>>          qio_channel_set_name(QIO_CHANNEL(sioc), name);
>>          if (qio_channel_socket_listen_sync(
>>                  sioc, rawaddrs[i], listenerr == NULL ? &listenerr : NULL) < 0) {
>> +            object_unref(OBJECT(sioc));
>>              continue;
>>          }
>>          listening = true;
>
> Regards,
> Daniel
>
