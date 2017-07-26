Received: from eggs.gnu.org ([2001:4830:134:3::10]:58981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daVet-0004kd-Oa
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daVep-0000p1-QI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:24:03 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daVep-0000no-LX
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:23:59 -0400
Received: by mail-qt0-x229.google.com with SMTP id p3so52761682qtg.2
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 16:23:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-17-f4bug@amsat.org>
	<1500986052.29790.5.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f561e5b5-6967-dab1-a285-cd756894b334@amsat.org>
Date: Wed, 26 Jul 2017 20:23:55 -0300
MIME-Version: 1.0
In-Reply-To: <1500986052.29790.5.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 16/35] usb/dev-mtp: fix use of
 uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/25/2017 09:34 AM, Gerd Hoffmann wrote:
>       case CMD_GET_OBJECT_INFO:
>> -        o = usb_mtp_object_lookup(s, c->argv[0]);
>> +        if (c->argc > 0) {
>> +            o = usb_mtp_object_lookup(s, c->argv[0]);
>> +        }
> 
> How about zero-initializing c->argv instead?

I checked the MTP specs rev. 1.1 and I understand the case argc == 0 
fits in "Invalid Parameter" section (F.2.30, code 0x201d).

So the correct patch is to queue a RES_INVALID_PARAMETER result.

I'll send another patch but since this require heavy testing this is 
probably 2.11 material now.

Regards,

Phil.
