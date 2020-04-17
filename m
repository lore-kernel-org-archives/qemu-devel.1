Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F5FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D975C20644
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D975C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digitalsignallabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPM2Z-0000Ac-1C
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 04:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yates@digitalsignallabs.com>) id 1jPG5F-00019d-Rk
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 21:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yates@digitalsignallabs.com>) id 1jPG5E-0006yc-2h
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 21:46:21 -0400
Received: from mail.onyx.syn-alias.com ([206.152.134.66]:59457
 helo=smtp.centurylink.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yates@digitalsignallabs.com>)
 id 1jPG5D-0006su-Kf
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 21:46:19 -0400
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=/DUmtE38f4iOwNXrSUBayA==:117 a=/DUmtE38f4iOwNXrSUBayA==:17
 a=KGjhK52YXX0A:10 a=cl8xLZFz6L8A:10 a=PPsO2EghCewA:10 a=eQrCS-SpgXYA:10
 a=YL6Xjd1eAAAA:8 a=yrnTiy7_AAAA:8 a=lBLTMJS-2gcmsWpGvOwA:9
 a=0u0qVQpVVqsDn71S:21 a=j6Lnkqpu-uj4ozWN:21 a=VqsvSLrz3NoJyWTxnQUA:9
 a=1zHEvBeRn2yyR2Sj:21 a=bgIN8SM0sFczpb_Z:21 a=B-T63VDYfxC_wYyR:21
 a=yLS1KB8ZbIgHeRWbGdJx:22 a=d2wp0cl8BqqoVUBAGsA6:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=bWyr8ysk75zN3GCy5bjg:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Feedback-ID: dfw:ctl:res:onyx
X-Authed-Username: eWF0ZXNmcmVlZGFyYW5keUBjZW50dXJ5bGluay5uZXQ=
Authentication-Results: smtp03.onyx.dfw.sync.lan
 smtp.user=yatesfreedarandy@centurylink.net; auth=pass (LOGIN)
Received: from [71.217.96.46] ([71.217.96.46:45440]
 helo=galois.digitalsignallabs.com)
 by smtp.centurylink.net (envelope-from <yates@digitalsignallabs.com>)
 (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPA
 id 58/93-22124-76A099E5; Thu, 16 Apr 2020 21:46:17 -0400
Received: from localhost.localdomain (unknown [71.217.96.46])
 by galois.digitalsignallabs.com (Postfix) with ESMTPA id E352E2E11B2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 21:46:14 -0400 (EDT)
From: Randy Yates <yates@digitalsignallabs.com>
To: qemu-devel@nongnu.org
Subject: QEMU Development Questions
Organization: Digital Signal Labs
Date: Thu, 16 Apr 2020 21:46:14 -0400
Message-ID: <87mu7ac2ah.fsf@digitalsignallabs.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-=-="
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
X-Received-From: 206.152.134.66
X-Mailman-Approved-At: Fri, 17 Apr 2020 04:03:55 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain

1      Introduction



I came to the QEMU project with the goal of writing a new machine. We are reverse
engineering this machine and do not have the SoC reference manual.  We do have
the flash code, the bare metal startup code.  Thus we're having to guess and infer a
lot about the machine from the code.  Since this is an ARM A9, my initial thought
was to base the new machine on the vexpress-a9.


I've been asking lots of questions in #qemu@irc.oftc.net and some of the folks
there (mainly pm215 and f4bug) suggested I put these questions and my comments
into writing and send out to the mailing list to help new people become familiar
with the project.


I confess, I am ignorant.  Some of the questions may not be QEMU questions at all
but ARM architecture, hardware, or other questions.  Please bear with me and help
me out.


It is believed we are using an ARM Cortex A9 MPCORE machine with 4 cores and
with  TrustZone  (and  possibly  hypervisor)  functionality.   The  machine  eventually
loads and runs linux, but we believe there are at least three levels of bootloaders
prior to linux:



    1.  bootrom

    2.  first-level bootloader.

    3.  second-level bootloader via an embedded elf file.



It appears that only two of the four cores are used and it appears to be an asymmetric
multiprocessing design,  in which the two cores are running different OSes,  one a
bare metal and the other linux.


The goal is to define the minimum amount of machine (cpu, sram, dram, itcm, dtcm,
gic, flash, ?)  be able to reverse engineer code up to the second-level bootloader.
Then hopefully we can leverage QEMU's capabilities, e.g., exception reporting in
the debug output, to determine missing functionality.


The QEMU project was git cloned on 4/16/2020.  The work is being done under
Fedora 31.



                                                  1




2      Questions



2.1      Top-Level  Architecture



There is a MachineClass, MachineState, and MachineInstance.  What are purposes
of these logical divisions?



2.2      Miscellaneous


    1.  Apparently the CPU has properties. What are the specific properties and their
        defaults?  How do you change a property's default value?

    2.  Ditto previous question for other machine components.

    3.  How do you model and implement startup from power on reset?


          (a) Bootrom code is modeled by specifying -bios !file? on the command line.
              What format should the code in !file? be?

         (b)  Bootrom code performs required initializations, e.g., populating the in-
              terrupt vector table at the appropriate spot, GIC? other registers?  Copy-
              ing code to DRAM?

          (c) Once bootrom code is finished, what happens?  Should it simply branch
              to the first-level bootloader (which is supposedly loaded into DRAM)?
              Is the reset vector used somehow?


    4.  I'm using the -pflash command-line option to map a copy of the flash code.
        Do you simply specify the address of an existing memory (DRAM) of where
        to load the file?  Is there a way to specify an entry point address (of where to
        begin execution).  How does this interact with the -bios option?

    5.  There may be custom hardware involved, e.g., GPIOs, I2Cs, etc.  How would
        these be defined in the machine?

    6.  Documentation for routing the monitor to another place (e.g., a telnet termi-
        nal) could be better.  pm215 gave me the following complex set of command-
        line options:


        -chardev  socket,id=monitor,host=127.0.0.1,port=4444,server,nowait,telnet  -mon  chardev=monitor,mode=readline


    7.  Ditto above comment for the -d option.

    8.  How are multiple cores traced in the debug output?

    9.  The vexpress code had clocks,  voltages,  etc.  defined.  Are these necessary
        for a bare-metal, base functioning machine?  Exactly which components are
        absolutely required?  E.g., is the busdev required?



                                                  2




  10.   Terminology questions:

          (a) Throughout  there  is  mention  of  highmem/lowmem.   What  does  this
              mean?

         (b)  Throughout  there  are  "PL"  devices,  e.g.,  PL111.   What  does  "PL"
              mean?



3      Conclusion



That's all for now - thanks for all help/suggestions/pointers/etc.



                                                  3
Randy Yates, DSP/Embedded Firmware Developer
Digital Signal Labs
http://www.digitalsignallabs.com

--=-=-=
Content-Type: text/html









<style>
*
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

p 
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

div
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

v
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

li
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

table 
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
  color: rgb(31,73,125);
%  background-color: white;
%  border-style: solid;
%  border-width: 1px;
%  border-color: white;
}

pre 
{
  font-size: 11px;
  font-weight: bold;
  font-family: Courier New, Courier, monospace;
%  color: #404040;
  background-color: #c0c0c0;
}

a, a:visited, a:hover, a:active 
{
  color: inherit;
}

.sig
{
  font-size: 10px;
  font-weight: bold;
}

</style>





<span style="color:#1F497D">
<span style="font-family:helvetica">

<div class="p"><!----></div>
 <a id="tth_sEc1"></a><h2>
1&nbsp;&nbsp;Introduction</h2>

<div class="p"><!----></div>
<p>I came to the QEMU&nbsp;project with the goal of writing a new machine.
We are reverse engineering this machine and do not have the SoC
reference manual. We do have the flash code, the bare metal startup
code. Thus we're having to guess and infer a lot about the machine
from the code. Since this is an ARM A9, my initial thought was to base
the new machine on the vexpress-a9.

<div class="p"><!----></div>
I've been asking lots of questions in <span style="color:#000000"><tt><b>#qemu@irc.oftc.net</b></tt></span> and
some of the folks there (mainly pm215 and f4bug) suggested I put these
questions and my comments into writing and send out to the mailing
list to help new people become familiar with the project.

<div class="p"><!----></div>
<p>I confess, I am ignorant. Some of the questions may not be QEMU&nbsp;questions at all but ARM architecture, hardware, or other questions.
Please bear with me and help me out.

<div class="p"><!----></div>
<p>It is believed we are using an ARM Cortex A9 MPCORE machine with 4
cores and with TrustZone (and possibly hypervisor) functionality. The
machine eventually loads and runs linux, but we believe there are at
least three levels of bootloaders prior to linux:

<ol type="1"><p>
<li> bootrom
<p>
<div class="p"><!----></div>
</li>

<li> first-level bootloader.
<p>
<div class="p"><!----></div>
</li>

<li> second-level bootloader via an embedded elf file.
<div class="p"><!----></div>
</li>
</ol>
<p>It appears that only two of the four cores are used and it appears
to be an asymmetric multiprocessing design, in which the two cores are
running different OSes, one a bare metal and the other linux.

<div class="p"><!----></div>
<p>The goal is to define the minimum amount of machine (cpu, sram,
dram, itcm, dtcm, gic, flash, ?) be able to reverse engineer code up
to the second-level bootloader. Then hopefully we can leverage QEMU's
capabilities, e.g., exception reporting in the debug output, to
determine missing functionality.

<div class="p"><!----></div>
<p>The QEMU&nbsp;project was git cloned on 4/16/2020. The work is being done
under Fedora 31.

<div class="p"><!----></div>
 <a id="tth_sEc2"></a><h2>
2&nbsp;&nbsp;Questions</h2>

<div class="p"><!----></div>
     <a id="tth_sEc2.1"></a><h3>
2.1&nbsp;&nbsp;Top-Level Architecture</h3>

<div class="p"><!----></div>
<p>There is a MachineClass, MachineState, and MachineInstance. What are purposes
of these logical divisions?

<div class="p"><!----></div>
     <a id="tth_sEc2.2"></a><h3>
2.2&nbsp;&nbsp;Miscellaneous</h3>

<div class="p"><!----></div>

<ol type="1"><p>
<li> Apparently the CPU has properties. What are the specific properties and their
defaults? How do you change a property's default value?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> Ditto previous question for other machine components.

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> How do you model and implement startup from power on reset? 

<div class="p"><!----></div>

<ol type="a"><p>
<li>  Bootrom code is modeled by specifying -bios &lt;file&#62; on the command line.
What format should the code in &lt;file&#62; be?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> Bootrom code performs required initializations, e.g.,
populating the interrupt vector table at the appropriate spot, GIC?
other registers? Copying code to DRAM?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> Once bootrom code is finished, what happens? Should it simply branch to
the first-level bootloader (which is supposedly loaded into DRAM)? Is the
reset vector used somehow?
<div class="p"><!----></div>
</li>
</ol>

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> I'm using the -pflash command-line option to map a copy of the flash code. Do you simply specify
the address of an existing memory (DRAM) of where to load the file? Is there a way to specify
an entry point address (of where to begin execution). How does this interact with the -bios option?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> There may be custom hardware involved, e.g., GPIOs, I2Cs,
etc. How would these be defined in the machine?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> Documentation for routing the monitor to another place (e.g., a telnet terminal) could be better. 
pm215 gave me the following complex set of command-line options:

<pre>
-chardev&nbsp;socket,id=monitor,host=127.0.0.1,port=4444,server,nowait,telnet&nbsp;-mon&nbsp;chardev=monitor,mode=readline&nbsp;

</pre>

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> Ditto above comment for the -d option.

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> How are multiple cores traced in the debug output?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> The vexpress code had clocks, voltages, etc. defined. Are these necessary for a bare-metal, base functioning
machine? Exactly which components are absolutely required? E.g., is the busdev required?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> Terminology questions:

<ol type="a"><p>
<li> Throughout there is mention of highmem/lowmem. What does this mean?

<div class="p"><!----></div>
<p>
<div class="p"><!----></div>
</li>

<li> Throughout there are "PL" devices, e.g., PL111. What does "PL" mean?
<div class="p"><!----></div>
</li>
</ol>
<div class="p"><!----></div>
</li>
</ol>

<div class="p"><!----></div>
 <a id="tth_sEc3"></a><h2>
3&nbsp;&nbsp;Conclusion</h2>

<div class="p"><!----></div>
<p>That's all for now - thanks for all help/suggestions/pointers/etc.

<div class="p"><!----></div>
</span></span>
--=-=-=--

