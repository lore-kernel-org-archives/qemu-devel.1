Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE1DC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEC0206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEC0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hslpD-0003uL-4z
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hslok-0003QD-Cn
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hsloj-0004UG-A8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hslog-0004Sm-Ni; Wed, 31 Jul 2019 06:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 390563079B65;
 Wed, 31 Jul 2019 10:26:41 +0000 (UTC)
Received: from localhost (ovpn-117-27.ams2.redhat.com [10.36.117.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 190A25D6A7;
 Wed, 31 Jul 2019 10:26:35 +0000 (UTC)
Date: Wed, 31 Jul 2019 11:26:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190731102634.GA22809@stefanha-x1.localdomain>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
 <20190730173441.26486-17-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20190730173441.26486-17-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 31 Jul 2019 10:26:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 16/16] block/io_uring: adds fd
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 11:04:41PM +0530, Aarushi Mehta wrote:

I'm concerned about file descriptor leaks.  fd_array[] keeps file
descriptors basically forever, even after the file is no longer in use
by the rest of QEMU.  There needs to be a call to unregister whenever a
file is closed elsewhere in QEMU.  For benchmarking and experimentation
the current code is okay, but for production usage the leak must be
prevented.

> +/**
> + * luring_fd_register:
> + *
> + * Register and unregisters file descriptors, see luring_fd_lookup
> + */
> +static int luring_fd_register(struct io_uring *ring, LuringFd *fd_reg, int fd)
> +{
> +    int ret, nr;
> +    GHashTable *lookup = fd_reg->fd_lookup;
> +    nr = g_hash_table_size(lookup);
> +
> +    /* Unregister */
> +    if (!fd) {
> +        ret = io_uring_unregister_files(ring);
> +        g_hash_table_remove_all(lookup);

Is it correct to clear the hash table be cleared if there was an error?

> +        return ret;
> +    }

Please make unregistering all files a separate function.  It's not
necessary to overload this function since this is a completely separate
operation.

> +
> +    /* If adding new, API requires older registrations to be removed */
> +    if (nr) {
> +        io_uring_unregister_files(ring);
> +    }
> +
> +    fd_reg->fd_array = g_realloc_n(fd_reg->fd_array, nr + 1, sizeof(int));
> +    fd_reg->fd_array[nr] = fd;
> +    fd_reg->fd_index = g_realloc_n(fd_reg->fd_index, nr + 1, sizeof(int));
> +    fd_reg->fd_index[nr] = nr;
> +
> +    g_hash_table_insert(lookup, &fd_reg->fd_array[nr], &fd_reg->fd_index[nr]);

fd_index[] is not necessary, you can cast nr to a gpointer instead to
store the data directly inside GHashTable:

  g_hash_table_insert(lookup, &fd_reg->fd_array[nr],
                      GINT_TO_POINTER(nr));

The hash table accesses can be made slightly more efficient by avoiding
the pointer dereference for keys as well:

  g_hash_table_insert(lookup, GINT_TO_POINTER(fd),
                      GINT_TO_POINTER(nr));

In this case fd_array[] is only used for the io_uring_register_files()
call and nothing else.  Remember to switch to g_direct_equal() and
g_direct_hash() in g_hash_table_new_full() if you make the key a direct
gpointer.

> +    trace_luring_fd_register(fd, nr);
> +    return io_uring_register_files(ring, fd_reg->fd_array, nr + 1);
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
> +    int *index, ret;
> +    if (!s->fd_reg.fd_lookup) {
> +        s->fd_reg.fd_lookup = g_hash_table_new_full(g_int_hash, g_int_equal,
> +                                                    g_free, g_free);

fd_array[] and fd_index[] are allocated in single allocations for the
entire array, therefore g_free(key) and g_free(value) on individual
elements is undefined behavior and could crash the program.  There
should be no destroy function for them.

Missing g_hash_table_unref() to free fd_lookup.

> +        luring_fd_register(&s->ring, &s->fd_reg, fd);
> +    }
> +    index = g_hash_table_lookup(s->fd_reg.fd_lookup, &fd);
> +
> +    if (!index) {
> +        ret = luring_fd_register(&s->ring, &s->fd_reg, fd);
> +        if (ret < 0) {
> +            g_hash_table_remove_all(s->fd_reg.fd_lookup);

Why is the hash table cleared and why are fd_array[]/fd_index[] left
behind?

> +            return ret;
> +        }
> +        index = g_hash_table_lookup(s->fd_reg.fd_lookup, &fd);
> +    }
> +    return *index;
> +}

What are the concerns about in-flight requests and how are they
addressed?  For example, if a request is in-flight and another request
wants to add a new fd then io_uring_unregister_files() and
io_uring_register_files() are called while a request is still in-flight.
How does the io_uring kernel code handle this?

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1BbLsACgkQnKSrs4Gr
c8gjmAgAn2MtuhC4RUecR6ZgZUf02is1XpdFYIOzrg9fEnSmXLGyvLrif9KibuxO
bpeTp/xdQqJ1R2e96Kn842NEjKgDroj/BQSzqggdAihM4qRg7xD98jqsVofMLNsh
IT2NDthhFnGw8EGViG39786Px3WxYgqweo4Zdabc+47g2j1y1QLyqGLNg0P2pSSl
GsoYXPaoDm5W421IeWUPga4cY+GnPAkrW1KMoZrn9a++FGngt8BGvdzWrxRjbf2p
jxMP3BWq2jkCXuMs6sZPu3NK+mw4OMTs4HX7EFlHBu4D8/6O5Y4H+EAxW4P60QVm
lGICfFjjXHXcoA8AKZNRb9rtIVjRQg==
=fYrp
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

