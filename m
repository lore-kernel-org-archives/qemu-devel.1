Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B3C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 07:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7828320760
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 07:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOGIBtwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7828320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kESa4-0006rB-CZ
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 03:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kESZT-0006QS-9K
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 03:25:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kESZQ-0001E8-VN
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 03:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599290707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PzKI6WsypmDOwSr4gjbdtwCD5z+i2rXuQux+4dzyheU=;
 b=TOGIBtwaYJJ2cfH94YxxG0+wNP2QqBo13hOGVklKfWo+n2y/mC30M0Y5OGaLTeoTUlpEdF
 9UbGjYLgvzV3UgQKklQFmvsxAe9gsFX286x9FfbRkK21qFxRK4yhUmB+AT/7z6ECrL+hS4
 4qhY6UbpcNmwDOInOeDEC5XJQJ4qv3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-ocdx85WmP8--ARATIyh-jw-1; Sat, 05 Sep 2020 03:25:05 -0400
X-MC-Unique: ocdx85WmP8--ARATIyh-jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B85E1DE08;
 Sat,  5 Sep 2020 07:25:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-27.ams2.redhat.com [10.36.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C61A19C59;
 Sat,  5 Sep 2020 07:25:02 +0000 (UTC)
Subject: Re: [PATCH v2] tests: Trying fixes test-replication.c on msys2.
To: luoyonggang@gmail.com
References: <20200903220655.1333-1-luoyonggang@gmail.com>
 <c11df65c-4503-d96d-3452-fe3ae1caca3a@redhat.com>
 <CAE2XoE_Gj2mp8qoqH97PMOHEEeA_HOKe3b7oN0YH=+RzEn0kMg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3e1e7a24-016f-b8c4-cc42-0977bc36402f@redhat.com>
Date: Sat, 5 Sep 2020 09:25:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_Gj2mp8qoqH97PMOHEEeA_HOKe3b7oN0YH=+RzEn0kMg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 03:25:07
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/09/2020 05.11, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Fri, Sep 4, 2020 at 9:07 PM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
> 
>     On 04/09/2020 00.06, Yonggang Luo wrote:
>     > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
>     <mailto:luoyonggang@gmail.com>>
>     > ---
>     >  tests/test-replication.c | 17 +++++++++++++----
>     >  1 file changed, 13 insertions(+), 4 deletions(-)
>     >
>     > diff --git a/tests/test-replication.c b/tests/test-replication.c
>     > index 9ab3666a90..d0e06f8d77 100644
>     > --- a/tests/test-replication.c
>     > +++ b/tests/test-replication.c
>     > @@ -23,14 +23,18 @@
>     > 
>     >  /* primary */
>     >  #define P_ID "primary-id"
>     > -static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
>     > +#define P_LOCAL_DISK "%s/p_local_disk.XXXXXX"
>     > +static char p_local_disk[PATH_MAX];
>     > 
>     >  /* secondary */
>     >  #define S_ID "secondary-id"
>     >  #define S_LOCAL_DISK_ID "secondary-local-disk-id"
>     > -static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
>     > -static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
>     > -static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
>     > +#define S_LOCAL_DISK "%s/s_local_disk.XXXXXX"
>     > +static char s_local_disk[PATH_MAX];
>     > +#define S_ACTIVE_DISK "%s/s_active_disk.XXXXXX"
>     > +static char s_active_disk[PATH_MAX];
>     > +#define S_HIDDEN_DISK "%s/s_hidden_disk.XXXXXX"
>     > +static char s_hidden_disk[PATH_MAX];
>     > 
>     >  /* FIXME: steal from blockdev.c */
>     >  QemuOptsList qemu_drive_opts = {
>     > @@ -571,7 +575,12 @@ static void setup_sigabrt_handler(void)
>     >  int main(int argc, char **argv)
>     >  {
>     >      int ret;
>     > +    const char *tmpdir = g_get_tmp_dir();
>     >      qemu_init_main_loop(&error_fatal);
>     > +    sprintf(p_local_disk, P_LOCAL_DISK, tmpdir);
>     > +    sprintf(s_local_disk, S_LOCAL_DISK, tmpdir);
>     > +    sprintf(s_active_disk, S_ACTIVE_DISK, tmpdir);
>     > +    sprintf(s_hidden_disk, S_HIDDEN_DISK, tmpdir);
> 
>     Sounds like the right way to go, but I think I'd do it without the
>     #defines and simply use the strings directly here, what do you think?
> 
> I place them at the same place by define is for easily readable, if I
> directly place at sprintf, then the code are harder to read 

IMHO it's easier to read the code the other way round: For understanding
the sprintf and its arguments, you have to know the format string, e.g.
will the "tmpdir" be handled via "%s", or "%p" or maybe something
completely different? If you then have to look up a macro first, it is a
cumbersome indirection. #defines are certainly fine for things that are
used multiple times, but here the strings are only used once, so the
indirection is really not needed.

 Thomas


