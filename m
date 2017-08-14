Received: from eggs.gnu.org ([2001:4830:134:3::10]:41697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhENN-0002Pb-Qf
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhENK-0002Bc-KV
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dhENK-0002BB-Dc
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:21:42 -0400
References: <1502712555-4587-1-git-send-email-jasowang@redhat.com>
	<1502712555-4587-2-git-send-email-jasowang@redhat.com>
	<20170814141420.5bd6a701.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <05439143-65b6-5936-c9cf-9d95387d9bbb@redhat.com>
Date: Mon, 14 Aug 2017 14:21:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170814141420.5bd6a701.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL V2] qemu-doc: Mention host_net_add/-remove
 in the deprecation chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 14.08.2017 14:14, Cornelia Huck wrote:
> On Mon, 14 Aug 2017 20:09:15 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The two HMP commands host_net_add and -remove have recently been
>> marked as deprecated, too, so we should now mention them in the
>> chapter of deprecated features.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>  qemu-doc.texi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index aeb7bc5..7b62fdf 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -3283,6 +3283,14 @@ by the ``convert -l snapshot_param'' argument instead.
>>  
>>  @section System emulator human monitor commands
>>  
>> +@subsection host_net_add (since 2.10.0)
>> +
>> +The ``host_net_add'' command is replaced by the ``netdev_add'' command.
>> +
>> +@subsection host_net_remove (since 2.10.0)
>> +
>> +The ``host_net_remove'' command is replaced by the ``host_net_remove'' command.
> 
> Err.. that does not look right...

Ah, right, that was the wrong version, I already sent a v2 here:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01954.html

 Thomas
