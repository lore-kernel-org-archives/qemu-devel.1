Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF2DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5747F20768
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwwuiiS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5747F20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDPN-0005oj-Hq
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFDOe-00058c-T9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:25:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFDOb-0003Sj-Oi
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599470704;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebHMQ6WaAb/MIlFy9+1QhA+l99LOR20IZu/um8tUmQc=;
 b=QwwuiiS+xUo5rkd4egRlQYwEgASK3lZ1YxjyfEgqKxFQUoAb9f5urlSD0j1LFI0SqjZtZO
 1UoQmod7vBx6VNwY/iKzl+dN2uJsjXdneOGhDxJsExrjZd3NHLkeof932JRZygOaQPu74W
 oiVnSxDWU3KTrwLQk1hbHc+PcqckvqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-qu6MNX77NZyu0i_W8RSA1A-1; Mon, 07 Sep 2020 05:25:02 -0400
X-MC-Unique: qu6MNX77NZyu0i_W8RSA1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2079E640F0;
 Mon,  7 Sep 2020 09:25:01 +0000 (UTC)
Received: from redhat.com (ovpn-114-70.ams2.redhat.com [10.36.114.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8861D5DA84;
 Mon,  7 Sep 2020 09:24:50 +0000 (UTC)
Date: Mon, 7 Sep 2020 10:24:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [PATCH 1/2] tests: Trying fixes test-replication.c on msys2/mingw.
Message-ID: <20200907092447.GC810755@redhat.com>
References: <20200905211038.904-1-luoyonggang@gmail.com>
 <20200905211038.904-2-luoyonggang@gmail.com>
 <5a0e9248-d2eb-a88e-4043-7104498cd804@weilnetz.de>
 <CAE2XoE-MuBNOGU5T_H_vgWYA5sU+HBjrk3tBa-=zJzpekWQcqw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-MuBNOGU5T_H_vgWYA5sU+HBjrk3tBa-=zJzpekWQcqw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 06, 2020 at 08:13:19PM +0800, 罗勇刚(Yonggang Luo) wrote:
> On Sun, Sep 6, 2020 at 5:49 AM Stefan Weil <sw@weilnetz.de> wrote:
> 
> > Am 05.09.20 um 23:10 schrieb Yonggang Luo:
> >
> > > On Windows there is no path like /tmp/s_local_disk.XXXXXX
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > ---
> > >  tests/test-replication.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tests/test-replication.c b/tests/test-replication.c
> > > index 9ab3666a90..3cf544a133 100644
> > > --- a/tests/test-replication.c
> > > +++ b/tests/test-replication.c
> > > @@ -23,14 +23,14 @@
> > >
> > >  /* primary */
> > >  #define P_ID "primary-id"
> > > -static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
> > > +static char p_local_disk[PATH_MAX];
> > >
> > >  /* secondary */
> > >  #define S_ID "secondary-id"
> > >  #define S_LOCAL_DISK_ID "secondary-local-disk-id"
> > > -static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
> > > -static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
> > > -static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
> > > +static char s_local_disk[PATH_MAX];
> > > +static char s_active_disk[PATH_MAX];
> > > +static char s_hidden_disk[PATH_MAX];
> > >
> > >  /* FIXME: steal from blockdev.c */
> > >  QemuOptsList qemu_drive_opts = {
> > > @@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
> > >  int main(int argc, char **argv)
> > >  {
> > >      int ret;
> > > +    const char *tmpdir = g_get_tmp_dir();
> > > +    sprintf(p_local_disk, "%s/p_local_disk.XXXXXX", tmpdir);
> > > +    sprintf(s_local_disk, "%s/s_local_disk.XXXXXX", tmpdir);
> > > +    sprintf(s_active_disk, "%s/s_active_disk.XXXXXX", tmpdir);
> > > +    sprintf(s_hidden_disk, "%s/s_hidden_disk.XXXXXX", tmpdir);
> > >      qemu_init_main_loop(&error_fatal);
> > >      bdrv_init();
> > >
> >
> >
> > Maybe it is possible to use get_tmp_filename() (which could be
> > simplified by using g_get_tmp_dir).
> >
> What  does get_tmp_filename mean? I didn't understand
> 
> >
> > And please use snprintf instead of sprintf. I am afraid that a path can
> > be longer than PATH_MAX, even if the tmpdir path is normally rather short.
> >
>  OK, I'll use  snprintf
> 
> >
> > You could also allocate the different filenames dynamically instead of
> > limiting them to PATH_MAX characters.
> >
> as a test, it's too complicated,

I really isn't hard to replace sprintf() with g_strdup_printf() and
then g_free() at the end of the test.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


