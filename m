Received: from eggs.gnu.org ([2001:4830:134:3::10]:37468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpAo-0004gb-OV
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 20:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpAl-0004yQ-KD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 20:29:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpAl-0004xA-Ar
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 20:29:51 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v141T9i1020321
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 20:29:49 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28cyk3svt2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 20:29:49 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 23:29:46 -0200
Date: Fri, 3 Feb 2017 23:29:37 -0200
From: joserz@linux.vnet.ibm.com
References: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
	<148615989046.33.5463181790096988546@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148615989046.33.5463181790096988546@eba24e3a0d7f>
Message-Id: <20170204012937.GA7402@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] POWER9 TCG enablements -
 part 13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, famz@redhat.com, david@gibson.dropbear.id.au

On Fri, Feb 03, 2017 at 02:11:31PM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> Your series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Subject: [Qemu-devel] [PATCH 0/4] POWER9 TCG enablements - part 13
> Message-id: 1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> # Useful git options
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com -> patchew/1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com
>  - [tag update]      patchew/20170203120254.15062-1-berrange@redhat.com -> patchew/20170203120254.15062-1-berrange@redhat.com
> Switched to a new branch 'test'
> 52f618a ppc: implement xssubqp instruction
> f7dfdbf ppc: implement xssqrtqp instruction
> 4d895a4 ppc: implement xsrqpxp instruction
> 5d49c07 ppc: implement xsrqpi[x] instruction
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/4: ppc: implement xsrqpi[x] instruction...
> ERROR: Macros with complex values should be enclosed in parenthesis
> #125: FILE: target/ppc/translate/vsx-ops.inc.c:106:
> +#define GEN_VSX_Z23FORM_300(name, opc2, opc3, opc4, inval) \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x00, opc4 | 0x0, inval), \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x08, opc4 | 0x0, inval), \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x10, opc4 | 0x0, inval), \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x0, inval), \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x00, opc4 | 0x1, inval), \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x08, opc4 | 0x1, inval), \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x10, opc4 | 0x1, inval), \
> +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x1, inval)
> 

I tried to improve it but this style is used everywhere

> total: 1 errors, 0 warnings, 103 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 2/4: ppc: implement xsrqpxp instruction...
> Checking PATCH 3/4: ppc: implement xssqrtqp instruction...
> Checking PATCH 4/4: ppc: implement xssubqp instruction...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
