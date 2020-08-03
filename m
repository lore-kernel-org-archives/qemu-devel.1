Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337E3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27BB2065E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWipvlBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27BB2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Vgv-0000pp-P7
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 04:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2VgE-0000Io-M5
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:18:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2VgC-0003g8-4j
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596442722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THXAl9yyzu2vwelnP2abs4RSXjAGnp+e17tfpdjZvD0=;
 b=gWipvlBCEMhB/Tiw+LYy9QAVe56OYyhIg0d0xjPW3ZI7G48J6PEs/fjwyu91hdn8zXhE0S
 L+WqxnvbijZ1UCzY2TQzy52iNc4VuV01oOGsPddQFHCPDIRmNEJ07sQHuwlX00Ja6faDRU
 jOZ/tcKdlWHnVor8aH2gL/t2V4T4ERE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-X8U-_icrPAuaiOrOEN4NPw-1; Mon, 03 Aug 2020 04:18:40 -0400
X-MC-Unique: X8U-_icrPAuaiOrOEN4NPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24DE8800138;
 Mon,  3 Aug 2020 08:18:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D128B272A3;
 Mon,  3 Aug 2020 08:18:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67FC41132FD2; Mon,  3 Aug 2020 10:18:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
Date: Mon, 03 Aug 2020 10:18:29 +0200
In-Reply-To: <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com> (Paolo
 Bonzini's message of "Fri, 31 Jul 2020 18:28:06 +0200")
Message-ID: <87d048i1m2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/07/20 17:07, Daniel P. Berrang=C3=A9 wrote:
>> The QAPI JSON-but-not file format is a case where I think we should just
>> adopt a standard file format no matter what. A conversion will have some
>> short term work, but this is really simple data to deal with and the cod=
e
>> involved is nicely self contained. Again I'm not saying QAPI maintainers
>> must do it, just put the idea out there as a piece of work that would
>> be welcomed if someone is interested in working ont.
>
> The main issues with JSON-but-not in QEMU are:
>
> - the 64-bit integers, which does not apply to the QAPI schema though

QMP only.  The QAPI schema does not use JSON numbers at all so far.

> - the comments, which are a common extension to JSON (see JSON5, NodeJS
> config files, json_verify's -c option, etc.) so I find it quite surprisin=
g
> that no off-the-shelf Python component can parse JSON + comments

QAPI schema only.  QMP does not support comments.

> - the single-quote strings, which are not particularly useful in QAPI sch=
ema

Every single string in the QAPI schema uses them, though.

I have no idea why Anthony put them in the QAPI schema language.

We could remove them from the QAPI schema language.  Flag day, and
git-blame becomes pretty much useless for a couple of years.

Removing them from QMP would be painless for QEMU itself, but could
upset QMP clients that (unwisely) use them.

> If we changed the single-quote strings to double-quote, jsonc.vim
> (https://github.com/neoclide/jsonc.vim) seems to support JSON + comments.
> In Emacs you'd probably add an epilogue like
>
> (defconst json-mode-comments-re (rx (group "#" (zero-or-more nonl) line-e=
nd)))
> (push (list json-mode-comments-re 1 font-lock-comment-face) json-font-loc=
k-keywords-1)
>
> Did I miss anything?

Let me reiterate that parsing the lower layer of the QAPI schema
language is the trivial part (because we made it trivial, accepting a
considerable hit to ergonomics).  For basic editor support, parsing the
lower layer is all you need.  But to truly work with the schema, you
need to grok the (less than trivial!) upper layer.  Making the lower
layer slightly more trivial is not going to help with that.

We can of course indulge in buyer's remorse on our choice to develop our
own schema language for QAPI.  But that's separate discussion.

As long as we have our own QAPI schema language, we should use a single
frontend for working with it.

> Besides that, why are we using Python and not JavaScript in the mode line=
?

Falls apart for # comments.  JavaScript uses // and /* */.

[...]


