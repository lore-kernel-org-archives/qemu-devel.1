Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B21CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010B4206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010B4206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBRj-0004ec-5d
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEBRD-0004E4-VQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:07:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEBRB-0001cM-P2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:07:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-9bObgg4TO8S1ZyKPd__Mdg-1; Fri, 04 Sep 2020 09:07:25 -0400
X-MC-Unique: 9bObgg4TO8S1ZyKPd__Mdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D428C2EC2;
 Fri,  4 Sep 2020 13:07:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-159.ams2.redhat.com [10.36.112.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C28137A1F4;
 Fri,  4 Sep 2020 13:07:22 +0000 (UTC)
Subject: Re: [PATCH v2] tests: Trying fixes test-replication.c on msys2.
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200903220655.1333-1-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c11df65c-4503-d96d-3452-fe3ae1caca3a@redhat.com>
Date: Fri, 4 Sep 2020 15:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903220655.1333-1-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 Xie Changlong <xiechanglong.d@gmail.com>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/09/2020 00.06, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-replication.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index 9ab3666a90..d0e06f8d77 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -23,14 +23,18 @@
>  
>  /* primary */
>  #define P_ID "primary-id"
> -static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
> +#define P_LOCAL_DISK "%s/p_local_disk.XXXXXX"
> +static char p_local_disk[PATH_MAX];
>  
>  /* secondary */
>  #define S_ID "secondary-id"
>  #define S_LOCAL_DISK_ID "secondary-local-disk-id"
> -static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
> -static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
> -static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
> +#define S_LOCAL_DISK "%s/s_local_disk.XXXXXX"
> +static char s_local_disk[PATH_MAX];
> +#define S_ACTIVE_DISK "%s/s_active_disk.XXXXXX"
> +static char s_active_disk[PATH_MAX];
> +#define S_HIDDEN_DISK "%s/s_hidden_disk.XXXXXX"
> +static char s_hidden_disk[PATH_MAX];
>  
>  /* FIXME: steal from blockdev.c */
>  QemuOptsList qemu_drive_opts = {
> @@ -571,7 +575,12 @@ static void setup_sigabrt_handler(void)
>  int main(int argc, char **argv)
>  {
>      int ret;
> +    const char *tmpdir = g_get_tmp_dir();
>      qemu_init_main_loop(&error_fatal);
> +    sprintf(p_local_disk, P_LOCAL_DISK, tmpdir);
> +    sprintf(s_local_disk, S_LOCAL_DISK, tmpdir);
> +    sprintf(s_active_disk, S_ACTIVE_DISK, tmpdir);
> +    sprintf(s_hidden_disk, S_HIDDEN_DISK, tmpdir);

Sounds like the right way to go, but I think I'd do it without the
#defines and simply use the strings directly here, what do you think?

 Thomas


PS: Please use scripts/get_maintainer.pl (or the MAINTAINERS file
directly) on your patches to find out the right maintainers that you
should put on CC: for every patch.


