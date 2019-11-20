Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA3A206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA3A206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUpn-00057N-HO
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXUn0-0003OJ-W0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXUmz-0002da-Ri
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:33:18 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:60199)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXUmz-0002d8-LU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:33:17 -0500
Received: from player726.ha.ovh.net (unknown [10.108.42.88])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id C78161ED22A
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 19:33:15 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id A581AC47BD6D;
 Wed, 20 Nov 2019 18:33:07 +0000 (UTC)
Date: Wed, 20 Nov 2019 19:33:06 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] pseries: disable migration-test if /dev/kvm cannot be used
Message-ID: <20191120193306.253f28a9@bahia.lan>
In-Reply-To: <20191120170955.242900-1-lvivier@redhat.com>
References: <20191120170955.242900-1-lvivier@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9721864224642799910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.113
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
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 18:09:55 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On ppc64, migration-test only works with kvm_hv, and we already
> have a check to verify the module is loaded.
> 
> kvm_hv module can be loaded in memory and /sys/module/kvm_hv exists,
> but on some systems (like build systems) /dev/kvm can be missing
> (by administrators choice).
> 
> And as kvm_hv exists test-migration is started but QEMU falls back to
> TCG because it cannot be used:
> 
>     Could not access KVM kernel module: No such file or directory
>     failed to initialize KVM: No such file or directory
>     Back to tcg accelerator
> 
> And as the test is done with TCG, it fails.
> 
> As for s390x, we must check for the existence and the access rights
> of /dev/kvm.
> 
> Reported-by: Cole Robinson <crobinso@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/migration-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index ac780dffdaad..2b25ba6d77f6 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -1349,7 +1349,8 @@ int main(int argc, char **argv)
>       * some reason)
>       */
>      if (g_str_equal(qtest_get_arch(), "ppc64") &&
> -        access("/sys/module/kvm_hv", F_OK)) {
> +        (access("/sys/module/kvm_hv", F_OK) ||
> +         access("/dev/kvm", R_OK | W_OK))) {
>          g_test_message("Skipping test: kvm_hv not available");
>          return g_test_run();
>      }


