Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24292C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF662204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF662204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htSY0-0005Do-47
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 04:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1htSXa-0004gw-3f
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1htSXY-0003eP-RB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1htSXW-0003d3-5D; Fri, 02 Aug 2019 04:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5652430832EA;
 Fri,  2 Aug 2019 08:03:49 +0000 (UTC)
Received: from localhost (ovpn-116-202.ams2.redhat.com [10.36.116.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4A7D5D704;
 Fri,  2 Aug 2019 08:03:42 +0000 (UTC)
Date: Fri, 2 Aug 2019 09:03:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190802080341.GD4227@stefanha-x1.localdomain>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
 <20190801234031.29561-17-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
In-Reply-To: <20190801234031.29561-17-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 08:03:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 16/17] block/io_uring: adds fd
 registration
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2019 at 05:10:30AM +0530, Aarushi Mehta wrote:

The fd lifecycle/leak issue remains.  After a drive is removed the
kernel still has a reference to the file.  If this repeats many times
our process will run out of open files.

A callback is required to unregister the file descriptor in
block/file-posix.c:

  static void raw_aio_detach_aio_context(BlockDriverState *bs)
  {
  #ifdef CONFIG_LINUX_IO_URING
      BDRVRawState *s = bs->opaque;
      LuringState *luring;

      luring = aio_get_linux_io_uring(bdrv_get_aio_context(bs));

      if (luring && s->fd >= 0) {
          luring_fd_unregister(luring, s->fd);
      }
  #endif
  }

I think this should eliminate fd leaks, but please test it.  You can use
drive_add/drive_del and device_add/device_del to hotplug and unplug
-drive and -device objects on the HMP monitor.  Use "ls -l /proc/PID/fd"
to see the list of currently open files.

> +    g_hash_table_insert(lookup, GINT_TO_POINTER(fd), GINT_TO_POINTER(nr));
> +    trace_luring_fd_register(fd, nr);

This trace event can be made even more useful by including
io_uring_register_files()'s return value so we know whether the kernel
accepted fd_array[] or not.

> +    return io_uring_register_files(ring, fd_reg->fd_array, nr + 1);
> +}
> +/**
> + * luring_fd_unregister:
> + *
> + * Unregisters file descriptors, TODO: error handling
> + */
> +static void luring_fd_unregister(LuringState *s)
> +{
> +        io_uring_unregister_files(&s->ring);
> +        g_hash_table_unref(s->fd_reg.fd_lookup);
> +        g_free(s->fd_reg.fd_array);

Please use 4-space indentation.

Missing s->fd_reg.fd_array = NULL so that the next g_realloc_n()
allocates a fresh array instead of trying to reallocate a freed pointer.

> +}
> +
> +/**
> + * luring_fd_lookup:
> + *
> + * Used to lookup fd index in registered array at submission time
> + * If the lookup table has not been created or the fd is not in the table,
> + * the fd is registered.
> + *
> + * If registration errors, the hash is cleared and the fd used directly
> + *
> + * Unregistering is done at luring_detach_aio_context
> + */
> +static int luring_fd_lookup(LuringState *s, int fd)
> +{
> +    int ret;
> +    void *index;
> +    GHashTable *lookup;
> +
> +    if (!s->fd_reg.fd_lookup) {
> +        s->fd_reg.fd_lookup = g_hash_table_new_full(g_direct_hash,
> +                                                    g_direct_equal,
> +                                                    g_free, g_free);
> +        luring_fd_register(&s->ring, &s->fd_reg, fd);
> +    }

This if statement can be eliminated:

  static void luring_fd_init(LuringState *s)
  {
      s->fd_reg.fd_lookup = g_hash_table_new_full(g_direct_hash,
                                                  g_direct_equal,
						  g_free, g_free);
  }

  static void luring_fd_cleanup(LuringState *s)
  {
      io_uring_unregister_files(&s->ring);
      g_hash_table_unref(s->fd_reg.fd_lookup);
      g_free(s->fd_reg.fd_array);
      s->fd_reg.fd_array = NULL;
  }

Call luring_fd_init() from luring_attach_aio_context() and call
luring_fd_cleanup() from luring_detach_aio_context().  This makes
luring_fd_lookup() simpler and gives a nice symmetry to attach/detach.

luring_fd_cleanup() is just luring_fd_unregister() renamed.

> +    lookup = s->fd_reg.fd_lookup;
> +    index = g_hash_table_lookup(lookup, GINT_TO_POINTER(fd));
> +
> +    if (index < 0) {
> +        ret = luring_fd_register(&s->ring, &s->fd_reg, fd);
> +
> +        if (ret < 0) {
> +            if (ret == -ENOMEM || ret == -EMFILE ||
> +                ret == -ENXIO) {
> +                return ret;
> +            } else {
> +                /* Should not reach here */
> +                g_hash_table_remove_all(lookup);
> +                g_free(s->fd_reg.fd_array);
> +                return ret;

I suggest making luring_fd_register() clean up after itself when an
error occurs.  Then you can change this code to:

  if (ret < 0) {
      return ret;
  }

It's usually convenient for a function to clean up after itself instead
of relying on the caller to do it since only the function knows exactly
what state has been modified so far.

The luring_fd_register() code becomes:

  ret = io_uring_register_files(ring, fd_reg->fd_array, nr + 1);
  if (ret == -ENOMEM || ret == -EMFILE || ret == -ENXIO) {
      /* Leave fd_array[] alone, fd will be overwritten next time anyway */
      g_hash_table_remove(lookup, GINT_TO_POINTER(fd));
  } else if (ret < 0) {
      /* A more severe error, clear out all registered fds */
      g_hash_table_remove_all(lookup);
      g_free(s->fd_reg.fd_array);
      s->fd_reg.fd_array = NULL;
  }
  return ret;

> +            }
> +        }
> +        index = g_hash_table_lookup(lookup, GINT_TO_POINTER(fd));

One final idea: make luring_fd_register() return the index on success so
callers don't need to look up the key again.  In luring_fd_register():

  if (ret < 0) {
      return ret;
  } else {
      return nr;
  }

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1D7l0ACgkQnKSrs4Gr
c8iGIQgAuCvmayfD0EAGAlwAaU9gN+af8XCzg12LnrrIRuVckptk8ToXcpV9S+ms
7xdPJNh3WDvsXJNAmlrqGVnEcvR1eFiuz9SEjOpf6H80rHRXFGpkV1r043VjZx15
9lh8y2d3+Hd4jup4pUzbfoUts4WD6X8ddMC18Cihso0JfTmhaHgHz+EGGfbpYbx/
R8Mu8Trsa/1kGm+vcfnInqu2OPGbeKibgxG9FRnQOLRff9z6AC1z3nMVC9zGsMgp
RWZjwnivNp1PvWqSAAzGWneOXi1JYoZRwiJrDexrsymNPx8AsdLITJIR/45B5xiM
QyhtOVB38v7+/BuUn+SCUoT5cjSRQg==
=nzhQ
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--

