Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EAC388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC452085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC452085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8Gy-0004Fb-La
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX8Bo-0006t2-Cg; Mon, 26 Oct 2020 15:29:56 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX8Bm-0001M8-Pr; Mon, 26 Oct 2020 15:29:56 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJEAX-1kqBAk2qIl-00KfW6; Mon, 26 Oct 2020 20:29:49 +0100
Subject: Re: [PATCH] scripts/qmp: delete 'qmp' script
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
References: <20201019210430.1063390-1-jsnow@redhat.com>
 <e057e735-1288-0aa3-0333-cc1d8188f704@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8b7a0e58-c711-e398-7fe8-0a1b7a87a586@vivier.eu>
Date: Mon, 26 Oct 2020 20:29:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e057e735-1288-0aa3-0333-cc1d8188f704@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AezqNs3HL9mnz03ldC6uN6GXcUnzasg2/aMl9zqVivFRVksLYi6
 v04UC3FyeMSEbSjHGZtthTZx02QWGNYzpWfwbOl+FYHkJYhorEZtHt/mjJr3WYROrjbGtry
 dHjc4GRT84dKzGQIazE/IjBqnwa3Xq6BFxerzNu/482bIB625bTFR/0Gr1+7PkvDP+9KMnG
 QxA1HMCEBZKVE56xAOzvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AwdiOVTPTOg=:GRmb09wPdWffxtrCaUZmd4
 RvcqyNanLLR8TbPm9TiPj+hG5N0aSUVXO70wT8PMAIPw2ZbIIIJAdF1sVv7MFJ9JN0N+fcjrE
 2/7JPCT86WW3/2DYCb9YHKvqdbuQDl1MLdpDC/Jva1Ki2rxFTwkOE4PxPHRz+4yKesOsVvX0E
 0BkeDL/jponuM/FyUaPm6URD9vjbdApCi2GKFTf5sCVSllXC3cwvi0RyceBYItnCAOTaEo7MB
 0TxkK8nGWq7eQK1P4jl5AdkQVeUXClY2TDCJNSDRgB68V97pOkJt1gzFwurf6RH3kR7Sr+v10
 ZYyknsx1yMFF9hLtWWN9ossHl5jDSPSCxE6vx6fjc/01GoD9UyXMCDyyLS8tk93u3SlhCZ+gT
 vq6y5SxRcHHYbKPkacTchDdqbi0rZwgwYIlcTNRZVRllgFDWdfq1AJDQGCRJIVo9eF8bW7zzK
 1KG2+qqJsQ==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 15:18:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/10/2020 à 07:44, Thomas Huth a écrit :
> On 19/10/2020 23.04, John Snow wrote:
>> This script has not seen a patch that was specifically for this script
>> since it was moved to this location in 2013, and I doubt it is used. It
>> uses "man qmp" for its help message, which does not exist. It also
>> presumes there is a manual page for qmp-XXX, for each defined qmp
>> command XXX. I don't think that's true.
>>
>> The format it expects arguments in is something like:
>>
>> block-dirty-bitmap-add --node=foo --name=bar
>>
>> and has no capacity to support nested JSON arguments, either.
>>
>> Most developers use either qmp-shell or socat (or pasting JSON directly
>> into qmp stdio), so this duplication and additional alternate syntax is
>> not helpful.
>>
>> Remove it. Leave a breadcrumb script just in case, to be removed next
>> release cycle.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  scripts/qmp/qmp | 131 +++---------------------------------------------
>>  1 file changed, 7 insertions(+), 124 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


