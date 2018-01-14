Received: from eggs.gnu.org ([2001:4830:134:3::10]:47084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eagMK-0005W3-Ns
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 06:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eagMH-0003mY-J5
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 06:21:52 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41996
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eagMH-0003jp-Bn
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 06:21:49 -0500
References: <151592855528.545.6795538165308775542@5adcb62bf0d6>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a2ccd140-d2ce-bda4-f48a-fff88b3977bb@ilande.co.uk>
Date: Sun, 14 Jan 2018 11:21:37 +0000
MIME-Version: 1.0
In-Reply-To: <151592855528.545.6795538165308775542@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/11] sun4u: APB tidy-up/rename and
 tracepoint conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, atar4qemu@gmail.com

On 14/01/18 11:15, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180114104751.21965-1-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCH 00/11] sun4u: APB tidy-up/rename and tracepoint conversions

(lots cut)

> === OUTPUT BEGIN ===
> Checking PATCH 1/11: apb: split simba PCI bridge into hw/pci-bridge/simba.c...
> Checking PATCH 2/11: simba: rename PBMPCIBridge and QOM types to reflect simba naming...
> Checking PATCH 3/11: apb: rename APB functions to use sabre prefix...
> Checking PATCH 4/11: apb: change pbm_pci_host prefix functions to use sabre_pci prefix...
> Checking PATCH 5/11: apb: QOMify sabre PCI host bridge...
> Checking PATCH 6/11: apb: rename QOM type from TYPE_APB to TYPE_SABRE...
> Checking PATCH 7/11: sun4u: rename apb variables and constants...
> Checking PATCH 8/11: apb: rename apb.c to sabre.c...
> ERROR: do not use C99 // comments
> #86: FILE: hw/pci-host/sabre.c:41:
> +//#define DEBUG_SABRE
> 
> total: 1 errors, 0 warnings, 188 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 9/11: pci: add trace-events support for hw/pci-host...
> Checking PATCH 10/11: sabre: convert from SABRE_DPRINTF macro to trace-events...
> Checking PATCH 11/11: sparc64: convert hw/sparc64/sparc64.c from DPRINTF macros to trace events...
> === OUTPUT END ===
> 
> Test command exited with code: 1

This is fine - it's just a side-effect of renaming DEBUG_APB to 
DEBUG_SABRE as part of the APB to sabre rename, and in fact this code is 
completely removed in patch 10 with the conversion to tracepoints.


ATB,

Mark.
