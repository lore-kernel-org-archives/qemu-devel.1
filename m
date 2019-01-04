Received: from eggs.gnu.org ([208.118.235.92]:46181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfNFR-0003wC-28
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfNFN-000162-Tg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:02:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfNFN-00015h-NK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:02:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so855085wmh.0
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 03:02:37 -0800 (PST)
References: <20190104082731.24967-1-pbonzini@redhat.com>
	<20190104082731.24967-2-pbonzini@redhat.com>
	<20190104102655.3bf599f5.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c60f6b8a-810a-cf50-aafd-8ca3991e23c2@redhat.com>
Date: Fri, 4 Jan 2019 12:02:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190104102655.3bf599f5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] scripts/update-linux-headers.sh:
 adjust for Linux 4.21-rc1 (or 5.0-rc1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mst@redhat.com

On 04/01/19 10:26, Cornelia Huck wrote:
> On Fri,  4 Jan 2019 09:27:30 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> There are three new indirect inclusions: vhost_types.h, which we'll
>> shortly put to use as a portable header and thus is copied to
>> standard-headers; and new per-subtarget versions of MIPS unistd.h
>> and PowerPC unistd.h.
>>
>> Because vhost.h includes vhost_types.h, we also need a proxy include
>> from linux/vhost.h to standard-headers.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  scripts/update-linux-headers.sh | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
> 
> I still think we could squash this change (and the description :) with
> the headers update, but I don't object to a separate change, either.

Me too, but I figured I'd rather not pull another tantrum like I did for
multiline comments...

Paolo
