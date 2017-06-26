Received: from eggs.gnu.org ([2001:4830:134:3::10]:42609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPY1k-0001V8-SV
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPY1d-00071S-9m
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:42:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPY1c-00070n-OH
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:42:13 -0400
Date: Mon, 26 Jun 2017 13:42:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170626174208.GA17935@flamenco>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan> <20170620172002.GA23332@flamenco>
	<CADR1n+Uw1Yg+0PdsaPwViXUFO7gGkW6ET_oSM86YQL+HRfM=0w@mail.gmail.com>
	<87lgokpoqy.fsf@frigg.lan> <87zicwgt3l.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zicwgt3l.fsf@frigg.lan>
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jayanto Minocha <jayanto@gmail.com>, qemu-devel@nongnu.org

On Sun, Jun 25, 2017 at 15:16:46 +0300, Lluís Vilanova wrote:
> Lluís Vilanova writes:
> 
> > Jayanto Minocha writes:
> >> Lluis,
> >> My modifications were almost the same as those done by Emilio. There were
> >> no memory trace events in the trace file.
> 
> > I'll take a look at it after I finish revamping the generic translation loop
> > series (hopefully today).
> 
> I just sent a patch that should fix it:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05491.html

Yay! That fixes the problem for me:

$ ../scripts/simpletrace.py trace-events-all trace-17579 | head -5
guest_mem_before_exec 0.000 pid=17579 __cpu=0x563780e726a0 vaddr=0x4000a2a030 info=0x4
guest_mem_before_exec 0.368 pid=17579 __cpu=0x563780e726a0 vaddr=0x4000a2a034 info=0x4
guest_mem_before_exec 0.162 pid=17579 __cpu=0x563780e726a0 vaddr=0x4000a2a034 info=0x14
guest_mem_before_exec 0.163 pid=17579 __cpu=0x563780e726a0 vaddr=0x4000a2a028 info=0x4
guest_mem_before_exec 0.109 pid=17579 __cpu=0x563780e726a0 vaddr=0x4000a2a02c info=0x4

Thanks,

		Emilio
