Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49387C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089DC208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089DC208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51308 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hblmD-0000ek-7i
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hbllI-0008KL-SW
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hbllH-0003VB-75
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hbllG-0003Ua-Ub
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:56:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 997A7356CA
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 12:56:53 +0000 (UTC)
Received: from work-vm (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94D2166D3E;
 Fri, 14 Jun 2019 12:56:43 +0000 (UTC)
Date: Fri, 14 Jun 2019 13:56:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190614125640.GE2785@work-vm>
References: <20190612105323.7051-1-quintela@redhat.com>
 <20190612105323.7051-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612105323.7051-7-quintela@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 14 Jun 2019 12:56:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 6/6] migration: Add zlib compression
 multifd support
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/qdev-properties.c |   2 +-
>  migration/ram.c           | 262 ++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json       |   2 +-
>  tests/migration-test.c    |   6 +
>  4 files changed, 270 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ebeeb5c88d..e40aa806e2 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -651,7 +651,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>  const PropertyInfo qdev_prop_multifd_compress = {
>      .name = "MultifdCompress",
>      .description = "multifd_compress values, "
> -                   "none",
> +                   "none/zlib",
>      .enum_table = &MultifdCompress_lookup,
>      .get = get_enum,
>      .set = set_enum,
> diff --git a/migration/ram.c b/migration/ram.c
> index 3b0002ddba..691ebd9108 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -583,6 +583,7 @@ exit:
>  #define MULTIFD_VERSION 1
>  
>  #define MULTIFD_FLAG_SYNC (1 << 0)
> +#define MULTIFD_FLAG_ZLIB (1 << 1)
>  
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> @@ -625,6 +626,15 @@ typedef struct {
>      RAMBlock *block;
>  } MultiFDPages_t;
>  
> +struct zlib_data {
> +    /* stream for compression */
> +    z_stream zs;
> +    /* compressed buffer */
> +    uint8_t *zbuff;
> +    /* size of compressed buffer */
> +    uint32_t zbuff_len;
> +};
> +
>  typedef struct {
>      /* this fields are not changed once the thread is created */
>      /* channel number */
> @@ -841,8 +851,260 @@ static MultiFDMethods multifd_nocomp_ops = {
>      .recv_pages = nocomp_recv_pages
>  };
>  
> +/* Multifd zlib compression */
> +
> +/**
> + * zlib_send_setup: setup send side
> + *
> + * Setup each channel with zlib compression.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    struct zlib_data *z = g_malloc0(sizeof(struct zlib_data));
> +    z_stream *zs = &z->zs;
> +
> +    p->data = z;
> +    zs->zalloc = Z_NULL;
> +    zs->zfree = Z_NULL;
> +    zs->opaque = Z_NULL;
> +    if (deflateInit(zs, migrate_compress_level()) != Z_OK) {
> +        error_setg(errp, "multifd %d: deflate init failed", p->id);
> +        return -1;

We're leaking 'z' here? Or does zlib_send_cleanup happy?

Other than that I think we're OK.

Dave

> +    }
> +    /* We will never have more than page_count pages */
> +    z->zbuff_len = page_count * qemu_target_page_size();
> +    z->zbuff_len *= 2;
> +    z->zbuff = g_try_malloc(z->zbuff_len);
> +    if (!z->zbuff) {
> +        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * zlib_send_cleanup: cleanup send side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void zlib_send_cleanup(MultiFDSendParams *p)
> +{
> +    struct zlib_data *z = p->data;
> +
> +    deflateEnd(&z->zs);
> +    g_free(z->zbuff);
> +    z->zbuff = NULL;
> +    g_free(p->data);
> +    p->data = NULL;
> +}
> +
> +/**
> + * zlib_send_prepare: prepare date to be able to send
> + *
> + * Create a compressed buffer with all the pages that we are going to
> + * send.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + */
> +static int zlib_send_prepare(MultiFDSendParams *p, uint32_t used, Error **errp)
> +{
> +    struct iovec *iov = p->pages->iov;
> +    struct zlib_data *z = p->data;
> +    z_stream *zs = &z->zs;
> +    uint32_t out_size = 0;
> +    int ret;
> +    uint32_t i;
> +
> +    for (i = 0; i < used; i++) {
> +        uint32_t available = z->zbuff_len - out_size;
> +        int flush = Z_NO_FLUSH;
> +
> +        if (i == used  - 1) {
> +            flush = Z_SYNC_FLUSH;
> +        }
> +
> +        zs->avail_in = iov[i].iov_len;
> +        zs->next_in = iov[i].iov_base;
> +
> +        zs->avail_out = available;
> +        zs->next_out = z->zbuff + out_size;
> +
> +        ret = deflate(zs, flush);
> +        if (ret != Z_OK) {
> +            error_setg(errp, "multifd %d: deflate returned %d instead of Z_OK",
> +                       p->id, ret);
> +            return -1;
> +        }
> +        out_size += available - zs->avail_out;
> +    }
> +    p->next_packet_size = out_size;
> +    p->flags |= MULTIFD_FLAG_ZLIB;
> +
> +    return 0;
> +}
> +
> +/**
> + * zlib_send_write: do the actual write of the data
> + *
> + * Do the actual write of the comprresed buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int zlib_send_write(MultiFDSendParams *p, uint32_t used, Error **errp)
> +{
> +    struct zlib_data *z = p->data;
> +
> +    return qio_channel_write_all(p->c, (void *)z->zbuff, p->next_packet_size,
> +                                 errp);
> +}
> +
> +/**
> + * zlib_recv_setup: setup receive side
> + *
> + * Create the compressed channel and buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    struct zlib_data *z = g_malloc0(sizeof(struct zlib_data));
> +    z_stream *zs = &z->zs;
> +
> +    p->data = z;
> +    zs->zalloc = Z_NULL;
> +    zs->zfree = Z_NULL;
> +    zs->opaque = Z_NULL;
> +    zs->avail_in = 0;
> +    zs->next_in = Z_NULL;
> +    if (inflateInit(zs) != Z_OK) {
> +        error_setg(errp, "multifd %d: inflate init failed", p->id);
> +        return -1;
> +    }
> +    /* We will never have more than page_count pages */
> +    z->zbuff_len = page_count * qemu_target_page_size();
> +    /* We know compression "could" use more space */
> +    z->zbuff_len *= 2;
> +    z->zbuff = g_try_malloc(z->zbuff_len);
> +    if (!z->zbuff) {
> +        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * zlib_recv_cleanup: setup receive side
> + *
> + * For no compression this function does nothing.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void zlib_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    struct zlib_data *z = p->data;
> +
> +    inflateEnd(&z->zs);
> +    g_free(z->zbuff);
> +    z->zbuff = NULL;
> +    g_free(p->data);
> +    p->data = NULL;
> +}
> +
> +/**
> + * zlib_recv_pages: read the data from the channel into actual pages
> + *
> + * Read the compressed buffer, and uncompress it into the actual
> + * pages.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int zlib_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **errp)
> +{
> +    uint32_t in_size = p->next_packet_size;
> +    uint32_t out_size = 0;
> +    uint32_t expected_size = used * qemu_target_page_size();
> +    struct zlib_data *z = p->data;
> +    z_stream *zs = &z->zs;
> +    int ret;
> +    int i;
> +
> +    if (p->flags != MULTIFD_FLAG_ZLIB) {
> +        error_setg(errp, "multifd %d: flags received %x flags expected %x",
> +                   p->id, MULTIFD_FLAG_ZLIB, p->flags);
> +        return -1;
> +    }
> +    ret = qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
> +
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    zs->avail_in = in_size;
> +    zs->next_in = z->zbuff;
> +
> +    for (i = 0; i < used; i++) {
> +        struct iovec *iov = &p->pages->iov[i];
> +        int flush = Z_NO_FLUSH;
> +
> +        if (i == used  - 1) {
> +            flush = Z_SYNC_FLUSH;
> +        }
> +
> +        zs->avail_out = iov->iov_len;
> +        zs->next_out = iov->iov_base;
> +
> +        ret = inflate(zs, flush);
> +        if (ret != Z_OK) {
> +            error_setg(errp, "multifd %d: inflate returned %d instead of Z_OK",
> +                       p->id, ret);
> +            return ret;
> +        }
> +        out_size += iov->iov_len;
> +    }
> +    if (out_size != expected_size) {
> +        error_setg(errp, "multifd %d: packet size received %d size expected %d",
> +                   p->id, out_size, expected_size);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static MultiFDMethods multifd_zlib_ops = {
> +    .send_setup = zlib_send_setup,
> +    .send_cleanup = zlib_send_cleanup,
> +    .send_prepare = zlib_send_prepare,
> +    .send_write = zlib_send_write,
> +    .recv_setup = zlib_recv_setup,
> +    .recv_cleanup = zlib_recv_cleanup,
> +    .recv_pages = zlib_recv_pages
> +};
> +
>  static MultiFDMethods *multifd_ops[MULTIFD_COMPRESS__MAX] = {
>      [MULTIFD_COMPRESS_NONE] = &multifd_nocomp_ops,
> +    [MULTIFD_COMPRESS_ZLIB] = &multifd_zlib_ops,
>  };
>  
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 153527e120..085eba8f07 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -493,7 +493,7 @@
>  #
>  ##
>  { 'enum': 'MultifdCompress',
> -  'data': [ 'none' ] }
> +  'data': [ 'none', 'zlib' ] }
>  
>  ##
>  # @MigrationParameter:
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index e5b8125e1c..e6995ae4e7 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -1219,6 +1219,11 @@ static void test_multifd_tcp_none(void)
>      test_multifd_tcp("none");
>  }
>  
> +static void test_multifd_tcp_zlib(void)
> +{
> +    test_multifd_tcp("zlib");
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -1275,6 +1280,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>      qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
>      qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
> +    qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib);
>  
>      ret = g_test_run();
>  
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

