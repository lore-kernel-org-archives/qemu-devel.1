Received: from eggs.gnu.org ([2001:4830:134:3::10]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1etk5w-0001pg-Gi
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 20:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1etk5r-0000bW-Hd
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 20:11:44 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1etk5r-0000b4-5y
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 20:11:39 -0500
Received: by mail-ua0-f171.google.com with SMTP id m43so2841538uah.1
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 17:11:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4d92bde9-85ce-e6b6-8bc6-30d80a9c4e3c@amd.com>
References: <152044348322.1455.3969737570225820649@bdbb90650ae5>
	<4d92bde9-85ce-e6b6-8bc6-30d80a9c4e3c@amd.com>
From: Fam Zheng <famz@redhat.com>
Date: Thu, 8 Mar 2018 09:10:55 +0800
Message-ID: <CAK1Eb9kiZ2j-syYGoYSCT9rWpd5xk0Bbpz2JReXRYAzMFxTVcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 00/28] x86: Secure Encrypted
 Virtualization (AMD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, mst@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>, agraf@suse.de, edgar.iglesias@xilinx.com, Markus Armbruster <armbru@redhat.com>, brogers@suse.com, Christian Borntraeger <borntraeger@de.ibm.com>, marcel@redhat.com, bp@suse.de, Thomas.Lendacky@amd.com, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, dgilbert@redhat.com, alistair.francis@xilinx.com, cornelia.huck@de.ibm.com, crosthwaite.peter@gmail.com, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Mar 8, 2018 at 4:35 AM, Brijesh Singh <brijesh.singh@amd.com> wrote:
> Hi,
>
> I have root caused and fixed the build issue seen with mingw32 compiler,
> the patch is very trivial (see below).
>
> I am looking for direction on how to submit the fix, should I resubmit
> the whole series or just send the updated  patch marked as "Patch v11.1
> ..." ? The "patch v11 11/28" included these headers in sev_i386.h, we
> need to move them in sev.c to fix this issue.

Please increment the version number and submit another whole series.

Fam
