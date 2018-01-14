Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaiIA-00083Z-Kk
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaiI7-0001T8-CG
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:25:42 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaiI7-0001SU-7R
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:25:39 -0500
Received: by mail-qt0-x241.google.com with SMTP id f2so11284414qtj.4
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 05:25:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <151592855528.545.6795538165308775542@5adcb62bf0d6>
	<a2ccd140-d2ce-bda4-f48a-fff88b3977bb@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b2111a3-2a85-3f72-b5e4-f0bb6d31ccb5@amsat.org>
Date: Sun, 14 Jan 2018 10:25:26 -0300
MIME-Version: 1.0
In-Reply-To: <a2ccd140-d2ce-bda4-f48a-fff88b3977bb@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: famz@redhat.com, atar4qemu@gmail.com

On 01/14/2018 08:21 AM, Mark Cave-Ayland wrote:
> On 14/01/18 11:15, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series seems to have some coding style problems. See output below
>> for
>> more information:
>>
>> Type: series
>> Message-id: 20180114104751.21965-1-mark.cave-ayland@ilande.co.uk
>> Subject: [Qemu-devel] [PATCH 00/11] sun4u: APB tidy-up/rename and
>> tracepoint conversions
> 
> (lots cut)
> 
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/11: apb: split simba PCI bridge into
>> hw/pci-bridge/simba.c...
>> Checking PATCH 2/11: simba: rename PBMPCIBridge and QOM types to
>> reflect simba naming...
>> Checking PATCH 3/11: apb: rename APB functions to use sabre prefix...
>> Checking PATCH 4/11: apb: change pbm_pci_host prefix functions to use
>> sabre_pci prefix...
>> Checking PATCH 5/11: apb: QOMify sabre PCI host bridge...
>> Checking PATCH 6/11: apb: rename QOM type from TYPE_APB to TYPE_SABRE...
>> Checking PATCH 7/11: sun4u: rename apb variables and constants...
>> Checking PATCH 8/11: apb: rename apb.c to sabre.c...
>> ERROR: do not use C99 // comments
>> #86: FILE: hw/pci-host/sabre.c:41:
>> +//#define DEBUG_SABRE
>>
>> total: 1 errors, 0 warnings, 188 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> Checking PATCH 9/11: pci: add trace-events support for hw/pci-host...
>> Checking PATCH 10/11: sabre: convert from SABRE_DPRINTF macro to
>> trace-events...
>> Checking PATCH 11/11: sparc64: convert hw/sparc64/sparc64.c from
>> DPRINTF macros to trace events...
>> === OUTPUT END ===
>>
>> Test command exited with code: 1
> 
> This is fine - it's just a side-effect of renaming DEBUG_APB to
> DEBUG_SABRE as part of the APB to sabre rename, and in fact this code is
> completely removed in patch 10 with the conversion to tracepoints.

This can be avoided moving patch #8 after #10, although not worthy IMHO.
