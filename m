Received: from eggs.gnu.org ([209.51.188.92]:46824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guK9r-0008Q3-La
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guK0N-0000pS-RM
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:36:58 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guK0N-0000cK-9G
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:36:55 -0500
Received: by mail-ot1-x344.google.com with SMTP id b3so11534442otp.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-2-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 16:36:28 +0000
Message-ID: <CAFEAcA-Csfn9qzLxcuCBtmjyCSLbtCELcr4+h=T79gum0JCHCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 01/18] update-linux-headers.sh: Copy new
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Since Linux'es ab66dcc76d "powerpc: generate uapi header and system call
> table files" there are 2 new files: unistd_32.h and unistd_64.h. These
> files content is moved from unistd.h so now we have to copy new files
> as well, just like we already do for other architectures; this does it
> for MIPS as well.
>
> Also, v5.0-rc2 moved vhost bits around in 4b86713236e4bd
> "vhost: split structs into a separate header file", add those too.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I think this fix is handled by commit a0a6ef91a4a4edde27
(now in master), yes ?

thanks
-- PMM
