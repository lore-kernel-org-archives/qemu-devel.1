Received: from eggs.gnu.org ([2001:4830:134:3::10]:53536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ctlaltlaltc@gmail.com>) id 1f9kQZ-0004Dk-Qx
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 00:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ctlaltlaltc@gmail.com>) id 1f9kQW-0006XN-Nr
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 00:47:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ctlaltlaltc@gmail.com>)
	id 1f9kQW-0006Wp-H9
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 00:47:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id p6so5130752pfn.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 21:47:08 -0700 (PDT)
From: Junpeng.Li <ctlaltlaltc@gmail.com>
References: <m2efj9q2i2.fsf@gmail.com>
	<d540f8da-3f0a-71a9-0050-8e8f95153f1c@redhat.com>
Date: Sat, 21 Apr 2018 12:46:53 +0800
In-Reply-To: <d540f8da-3f0a-71a9-0050-8e8f95153f1c@redhat.com> (Eric Blake's
	message of "Fri, 20 Apr 2018 14:06:31 -0500")
Message-ID: <87lgdhrwsi.fsf@workstation.novalocal>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] qemu-io read do not dump buffer when in quiet mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 04/20/2018 11:14 AM, Junpeng.Li wrote:
>> 
>> Hi, everyone. I found a question or maybe a bug during use qemu-io to read
>> a range file and take the params -vq to dump buffer and do not show
>> I/O statistics. I use the params -vq what i want is just dump buffer
>> but do not show I/O statistics, but as the result show it is not.
>> 
>> Like below command, it do not dump buffer to standard output.
>> 
>> qemu-io -r -c "read -vq 0 1024" /tmp/test.qcow2
>> 
>> I saw the source code, when has qflag value it just goto out and do
>> not dump buffer when qflag and vflag has value at the same time.
>> 
>>     if (qflag) {
>>         goto out;
>>     }
>> 
>>     if (vflag) {
>>         dump_buffer(buf, offset, qiov.size);
>>     }
>> 
>> quiet mode here, it mean do not show I/O statistics or mean complete quiet?
>
> You're welcome to provide a patch to make it have saner behavior.  As
> long as running qemu-iotests doesn't break, we are pretty much free to
> refactor qemu-io as it is more a tool for internal testing than for
> external use.
Sorry for my question description and thanks your explanation.

--
BestRegard,
JPL
