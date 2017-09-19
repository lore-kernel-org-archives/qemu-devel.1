Received: from eggs.gnu.org ([2001:4830:134:3::10]:35639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duLZQ-000405-Od
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duLZN-0008Td-Vq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:40:24 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:52855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duLZN-0008T0-Pk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:40:21 -0400
Received: by mail-io0-x232.google.com with SMTP id i197so431855ioe.9
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:40:21 -0700 (PDT)
References: <20170918163322.206581-1-borntraeger@de.ibm.com>
	<a82be132-6363-6875-9cb2-837eb9787ac4@redhat.com>
	<91de41ca-ca4f-8c80-6bbf-e03eefb6ae0a@de.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1685829b-db95-8cc3-19bc-4764cc4fbc7c@linaro.org>
Date: Tue, 19 Sep 2017 11:40:01 -0500
MIME-Version: 1.0
In-Reply-To: <91de41ca-ca4f-8c80-6bbf-e03eefb6ae0a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On 09/18/2017 12:22 PM, Christian Borntraeger wrote:
> On 09/18/2017 06:51 PM, David Hildenbrand wrote:
>> kvm-s390 is wrong. This is general s390x and should be named s390/s390x
>> and GuestPanicInformationS390(x). One can argue about s390 v s390x. See
>> last comment in this mail.
> 
> 
> Yes, will remove the kvm part and only use s390. Not sure about s390 vs. s390x.
> I slightly prefer the s390 name as in the kernel but I really do not care if
> we follow the s390x as in QEMU. Conny, any opinion?

Note that qemu is inconsistent here:

  target/s390x
  tcg/s390

which is arguably exactly wrong because target/s390x handles 32-bit mode,
whereas tcg/s390 requires 64-bit mode.  ;-)


r~
