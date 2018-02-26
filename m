Received: from eggs.gnu.org ([2001:4830:134:3::10]:35480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRpx-0003wp-5W
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRpu-00005H-E5
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:05:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqRpu-000058-8x
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:05:34 -0500
References: <1519683480-33201-1-git-send-email-mjc@sifive.com>
	<CAHNT7Nts7hHdrXe9-eVCG5h050bt=pgtTfeDGZ+BBpie3uz6wA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f1f0ced-fced-046f-1cef-a62b057b0634@redhat.com>
Date: Mon, 26 Feb 2018 17:05:18 -0600
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nts7hHdrXe9-eVCG5h050bt=pgtTfeDGZ+BBpie3uz6wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/26/2018 04:24 PM, Michael Clark wrote:
> I've pushed a signed tag which includes the cover letter for the pull
> request.
> 
> https://github.com/riscv/riscv-qemu/releases/tag/riscv-qemu-upstream-v7
> 
> Apologies. I'm not exactly sure how to format a pull request email.

I use:

$ git request-pull origin repo $TAG | xclip
$ git send-email --confirm=always --annotate \
    --subject-prefix=PULL origin

then paste in the generated cover letter to the templated 00/NN.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
