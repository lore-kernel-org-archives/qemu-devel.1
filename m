Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEBEC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 16:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3502078E
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/SWScRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3502078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEb8L-00079B-1I
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 12:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEb7W-0006UD-Q7
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 12:32:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEb7U-0002rJ-HL
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 12:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599323571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5cEMyATCY0fjuQui5w3q9mf35qHTBoMqQfq51N0kDw=;
 b=M/SWScRJgOr+ShzvqbVS8v5fzJaH2F+NBIaqzDCLOMzxTtB9/ooJQBziALPMxWXViXUHtP
 UtDECZprCTcEXhB18DBcPmAFgOaG/PkucVjo5FmGJOZfhEtXKB6xlM4A2UT7N2v0HzhSC0
 rTirqhVFf1SZyc+NoRACLM9kgWY+OrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-DtreOU2MOiScMbymHrapSw-1; Sat, 05 Sep 2020 12:32:49 -0400
X-MC-Unique: DtreOU2MOiScMbymHrapSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2729E80BCA1;
 Sat,  5 Sep 2020 16:32:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-44.ams2.redhat.com [10.36.112.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D3BA60C0F;
 Sat,  5 Sep 2020 16:32:35 +0000 (UTC)
Subject: Re: [PATCH] tests: fixes test-vmstate.c compile error on msys2
To: luoyonggang@gmail.com
References: <20200905063813.1875-1-luoyonggang@gmail.com>
 <aed3143c-5bf5-3b40-2c7c-1db2ac43f4c9@redhat.com>
 <CAE2XoE-456_zDPo46nH2erB6t8NrF5jpfRT7UcCtsCF7ts_H7Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <40361975-5c12-e0a6-0f54-bf0809b42adb@redhat.com>
Date: Sat, 5 Sep 2020 18:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-456_zDPo46nH2erB6t8NrF5jpfRT7UcCtsCF7ts_H7Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 12:32:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-level <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/09/2020 18.16, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Sat, Sep 5, 2020 at 4:48 PM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
> 
>     On 05/09/2020 08.38, Yonggang Luo wrote:
>     > ../tests/test-vmstate.c: In function 'int_cmp':
>     > ../tests/test-vmstate.c:884:5: error: unknown type name 'uint';
>     did you mean 'uInt'?
>     >   884 |     uint ua = GPOINTER_TO_UINT(a);
>     >       |     ^~~~
>     >       |     uInt
>     > ../tests/test-vmstate.c:885:5: error: unknown type name 'uint';
>     did you mean 'uInt'?
>     >   885 |     uint ub = GPOINTER_TO_UINT(b);
>     >       |     ^~~~
>     >       |     uInt
>     > make: *** [Makefile.ninja:5461：tests/test-vmstate.exe.p/test-
>     vmstate.c.obj] 错误 1
>     >
>     > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
>     <mailto:luoyonggang@gmail.com>>
>     > ---
>     >  tests/test-vmstate.c | 4 ++--
>     >  1 file changed, 2 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
>     > index f7b3868881..f8de709a0b 100644
>     > --- a/tests/test-vmstate.c
>     > +++ b/tests/test-vmstate.c
>     > @@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a,
>     gconstpointer b, gpointer user_data)
>     >  /* ID comparison function */
>     >  static gint int_cmp(gconstpointer a, gconstpointer b, gpointer
>     user_data)
>     >  {
>     > -    uint ua = GPOINTER_TO_UINT(a);
>     > -    uint ub = GPOINTER_TO_UINT(b);
>     > +    guint ua = GPOINTER_TO_UINT(a);
>     > +    guint ub = GPOINTER_TO_UINT(b);
>     >      return (ua > ub) - (ua < ub);
>     >  }
> 
>     Reviewed-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>>
> 
> Does this means quened or to be queued, if that's true, will skip this
> next revision 

No, "Reviewed-by" just means that somebody looked at the patch and
thinks it is right. It does not mean that it is queued yet, but it
certainly helps that the patch gets accepted.
But I've also put the qemu-trivial mailing list on CC: - trivial paches
like this can often get picked up more easily via the trivial queue.
Otherwise this should maybe get merged via the migration tree, or Alex'
or my testing tree.

 Thomas


