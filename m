Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FA2C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2453C206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2453C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is505-0006vY-8X
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1is4zR-0006QU-CG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1is4zP-0002p8-P3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:15:13 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:49636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1is4zP-0002lp-Ia
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:15:11 -0500
Received: from player688.ha.ovh.net (unknown [10.108.35.124])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4EA7911DF36
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 14:15:07 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 5AAACE34C12A;
 Thu, 16 Jan 2020 13:15:05 +0000 (UTC)
Date: Thu, 16 Jan 2020 14:15:03 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 02/11] 9pfs: require msize >= 4096
Message-ID: <20200116141503.32e36561@bahia.lan>
In-Reply-To: <49ff399635ccfd21858b15417a398df362ff0b90.1578957500.git.qemu_oss@crudebyte.com>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <49ff399635ccfd21858b15417a398df362ff0b90.1578957500.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7050948170414201152
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.37.72
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 23:21:04 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> A client establishes a session by sending a Tversion request along with
> a 'msize' parameter which client uses to suggest server a maximum
> message size ever to be used for communication (for both requests and
> replies) between client and server during that session. If client
> suggests a 'msize' smaller than 4096 then deny session by server
> immediately with an error response (Rlerror for "9P2000.L" clients or
> Rerror for "9P2000.u" clients) instead of replying with Rversion.
> 
> Introduction of a minimum msize is required to prevent issues in
> responses to numerous individual request types. For instance with a
> msize of < P9_IOHDRSZ no useful operations would be possible at all.

P9_IOHDRSZ is really specific to write/read operations. 

/*
 * ample room for Twrite/Rread header
 * size[4] Tread/Twrite tag[2] fid[4] offset[8] count[4]
 */
#define P9_IOHDRSZ 24

As you see P9_IOHDRSZ is approximately the size of a Twrite header.
Its primary use is to inform the client about the 'count' to use for
Twrite/Tread messages (see get_iounit()).

Not sure it helps to mention P9_IOHDRSZ since we're going to choose
something much greater. I'd personally drop this sentence.

> Furthermore there are some responses which are not allowed by the 9p
> protocol to be truncated like e.g. Rreadlink which may yield up to

No message may be truncated in any way actually. The spec just allows
an exception with the string part of Rerror.

Maybe just mention that and say we choose 4096 to be able to send
big Rreadlink messages.

> a size of PATH_MAX which is usually 4096. Hence this size was chosen
> as min. msize for server, which is already the minimum msize of the
> Linux kernel's 9pfs client. By forcing a min. msize already at
> session start (when handling Tversion) we don't have to check for a
> minimum msize on a per request type basis later on during session,
> which would be much harder and more error prone to maintain.
> 
> This is a user visible change which should be documented as such
> (i.e. in public QEMU release changelog).
> 

This last sentence isn't informative in the commit message. This
kind of indication should be added after the --- below.

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

LGTM

With an updated changelog,

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.c | 12 ++++++++++++
>  hw/9pfs/9p.h | 11 +++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 520177f40c..a5fbe821d4 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1363,8 +1363,20 @@ static void coroutine_fn v9fs_version(void *opaque)
>          s->proto_version = V9FS_PROTO_2000L;
>      } else {
>          v9fs_string_sprintf(&version, "unknown");
> +        /* skip min. msize check, reporting invalid version has priority */
> +        goto marshal;
>      }
>  
> +    if (s->msize < P9_MIN_MSIZE) {
> +        err = -EMSGSIZE;
> +        error_report(
> +            "9pfs: Client requested msize < minimum msize ("
> +            stringify(P9_MIN_MSIZE) ") supported by this server."
> +        );
> +        goto out;
> +    }
> +
> +marshal:
>      err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
>      if (err < 0) {
>          goto out;
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 3904f82901..6fffe44f5a 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -100,6 +100,17 @@ typedef enum P9ProtoVersion {
>      V9FS_PROTO_2000L = 0x02,
>  } P9ProtoVersion;
>  
> +/**
> + * @brief Minimum message size supported by this 9pfs server.
> + *
> + * A client establishes a session by sending a Tversion request along with a
> + * 'msize' parameter which suggests the server a maximum message size ever to be
> + * used for communication (for both requests and replies) between client and
> + * server during that session. If client suggests a 'msize' smaller than this
> + * value then session is denied by server with an error response.
> + */
> +#define P9_MIN_MSIZE    4096
> +
>  #define P9_NOTAG    UINT16_MAX
>  #define P9_NOFID    UINT32_MAX
>  #define P9_MAXWELEM 16


