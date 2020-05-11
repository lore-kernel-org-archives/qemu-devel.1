Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0DBC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5902075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5902075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4Pi-0004WA-Rz
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jY4P4-0003dS-Dh
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:07:14 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:35778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jY4P3-0007Ro-7e
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:07:14 -0400
Received: from player728.ha.ovh.net (unknown [10.108.42.192])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id E222920BBEC
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 11:07:10 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id BCCFC12223515;
 Mon, 11 May 2020 09:07:06 +0000 (UTC)
Subject: Re: [PATCH 3/6] target/ppc: Don't initialize some local variables in
 ppc_radix64_xlate()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
 <158887241032.1564424.1335205982073200922.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7aa5f210-6a03-7e66-ba3c-017704415989@kaod.org>
Date: Mon, 11 May 2020 11:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158887241032.1564424.1335205982073200922.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1566689724416625491
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrledtgddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.124.17; envelope-from=clg@kaod.org;
 helo=20.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 05:07:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 7:26 PM, Greg Kurz wrote:
> It is the job of the ppc_radix64_get_fully_qualified_addr() function
> which is called at the beginning of ppc_radix64_xlate() to set both
> lpid *and* pid. It doesn't buy us anything to initialize them first.
> 
> Worse, a bug in ppc_radix64_get_fully_qualified_addr(), eg. failing to
> set either lpid or pid, would be undetectable by static analysis tools
> like coverity.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/mmu-radix64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index c76879f65b78..5e2d912ee346 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -433,7 +433,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                               bool cause_excp)
>  {
>      CPUPPCState *env = &cpu->env;
> -    uint64_t lpid = 0, pid = 0;
> +    uint64_t lpid, pid;
>      ppc_v3_pate_t pate;
>      int psize, prot;
>      hwaddr g_raddr;
> 

I am seeing this failure with gcc version 9.3.1 20200408 (Red Hat 9.3.1-2) (GCC) 

target/ppc/mmu-radix64.c: In function ‘ppc_radix64_xlate’:
target/ppc/mmu-radix64.c:314:12: error: ‘pid’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  314 |     offset = pid * sizeof(struct prtb_entry);
      |     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
target/ppc/mmu-radix64.c:439:20: note: ‘pid’ was declared here
  439 |     uint64_t lpid, pid;
      |                    ^~~
target/ppc/mmu-radix64.c:458:14: error: ‘lpid’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  458 |         if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC      ppc64-softmmu/target/ppc/fpu_helper.o


This seems like a compiler optimization issue.

C.

