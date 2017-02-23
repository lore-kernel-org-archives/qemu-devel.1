Received: from eggs.gnu.org ([2001:4830:134:3::10]:49547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cgrCL-0000kG-Vh
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cgrCI-0001az-TH
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:04:33 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1cgrCI-0001ap-N2
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:04:30 -0500
Received: by mail-pf0-x243.google.com with SMTP id c193so1434592pfb.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 03:04:30 -0800 (PST)
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <dbe4bc8c-7c84-e4ed-9de9-266752ebb9e2@ozlabs.ru>
Date: Thu, 23 Feb 2017 22:04:23 +1100
MIME-Version: 1.0
In-Reply-To: <fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, zhong@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>

On 23/02/17 19:35, Paolo Bonzini wrote:
> 
> 
> On 23/02/2017 05:20, Alexey Kardashevskiy wrote:
>> First, Paolo is right and ram_device_mem_ops::endianness should be
>> host-endian which happens to be little in our test case (ppc64le)
> 
> So you tested a ppc64 BE guest and it works?

Yes. Setting ram_device_mem_ops.endianness = DEVICE_LITTLE_ENDIAN does the
job for both LE and BE guests on the LE host.



-- 
Alexey
