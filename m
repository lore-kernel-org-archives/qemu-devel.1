Received: from eggs.gnu.org ([2001:4830:134:3::10]:49552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUrnZ-0007DL-Aw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUrnU-00062p-G2
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:49:41 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUrnU-00062f-9M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:49:36 -0400
Received: by mail-wr0-f177.google.com with SMTP id k67so174987019wrc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 02:49:36 -0700 (PDT)
References: <201707111733232926663@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00359765-eb19-3d00-4e9d-b3d5ba941469@redhat.com>
Date: Tue, 11 Jul 2017 11:49:33 +0200
MIME-Version: 1.0
In-Reply-To: <201707111733232926663@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIIFYyXSBjaGFyZGV2?=
 =?utf-8?q?=3A_fix_parallel_device_can=27t_be_reconnect?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: marcandre.lureau@redhat.com, wang.yechao255@zte.com.cn, qemu-devel@nongnu.org

On 11/07/2017 11:33, peng.hao2@zte.com.cn wrote:
>>> +    if (qemu_chr_null_be_can_read(chr)) {
>>> +        size = tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN)
>>
>> It would be better not to destroy data in the channel, because the
>> device could set handlers later.
>
> This device do not register a chr_read function,so it's safe to
> destroy data(no read handler).

I agree, but this code doesn't know that the device is not changing
handlers later.

Paolo
