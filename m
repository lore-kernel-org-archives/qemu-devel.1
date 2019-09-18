Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB27C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C2A214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv6yldQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C2A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAW7u-0005q5-C4
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAW6F-0005B9-Vw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAW6E-0003q2-T8
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:18:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iAW6E-0003pP-MX; Wed, 18 Sep 2019 05:18:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so1639723wmj.5;
 Wed, 18 Sep 2019 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tYcFHlIdPCYRbCGYtPrXxlfR5WwE2gwfuE3sRz16YfQ=;
 b=sv6yldQmVVkVgM7+4lHMBU3frqMnpLvsAs5WOhO5PposeyK4UAQvRaBDZM7UhUv3ea
 6h97Aw/ddY7uMyqQBqElcMG7YNaNmzsCKUOj1OFw90Aa/thgYuAJOthSgSL/0U/KnF95
 EIoL4GcDMBGZMJ3IkuXMXQBqIkhSwHR2Qw0q1P50yhgRQ65graN/T5AMJ/i4pFNj/22a
 COShdJim2yi6fI+/hwr1ZkqQ3DjTVE4CFPF1eUpNQDTv8TZJRlFyGOr5vDNG5397IMjL
 p33IeQAKda2LHnmJMORinnCrmYRL42t+eaL2vFV+iZlNKaNLIzwRHrniXA9dpXuk4Xy6
 8FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tYcFHlIdPCYRbCGYtPrXxlfR5WwE2gwfuE3sRz16YfQ=;
 b=shrEfNHh2kJMnIEzhJmXW0GbyneaK+DsL+HezjbcQO6zUAgIr6EBx6j7ljTq86HXAd
 FCS4sj7K1fhPrhTqPpE1lhFHBgtRkblO7YaL/H7/DGBJB0H4elKOxryUh62QZTuroZvK
 fE+XUS+1ze4gXH4v27Cqrzlm38RImgtt6wmHn0utMuWnKlxk0fx42Fx7eU5jdsHJTuu7
 VTFBy+hV1Tf9MduA5luvDMBcOf5HUtwLrevQEbj+udmaxlLtZCb9DFtkXjGoPrQtyK6t
 pb3/1x89tDr2F4GdFp1zcmIGdsBLOuf+GNSs5GO/QtX1vG41sMvOGJ/urvak1740zVKY
 U1nw==
X-Gm-Message-State: APjAAAUQ1pngBHG3PpYwTo4v8yXjTfYT77ZKXxgubGhVrFstl6ZPJPUs
 XxMdhT6t7Rsg7CIYhIsQ5Nk=
X-Google-Smtp-Source: APXvYqwS7UNTezcTw1YfzWVVcIttMtQRQu+Q4uwXmHEHfm6kDda+fVg7xy7u6HeZdbW7XZcSAq4hKA==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr2027974wmj.58.1568798289472; 
 Wed, 18 Sep 2019 02:18:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z4sm5182700wrh.93.2019.09.18.02.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 02:18:08 -0700 (PDT)
Date: Wed, 18 Sep 2019 10:18:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190918091807.GA26027@stefanha-x1.localdomain>
References: <20190916095121.29506-1-philmd@redhat.com>
 <20190916095121.29506-2-philmd@redhat.com>
 <097f47ce-60a6-109f-e210-0844efed6a32@redhat.com>
 <d86629a7-510c-5a33-36f3-f33284e1ba5e@redhat.com>
 <180c6b99-deee-aa8d-01b6-0ec75bab4d70@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <180c6b99-deee-aa8d-01b6-0ec75bab4d70@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 1/2] trace: Remove trailing newline in
 events
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 12:41:44PM -0400, John Snow wrote:
> On 9/16/19 12:40 PM, Philippe Mathieu-Daud=E9 wrote:
> > On 9/16/19 6:36 PM, Eric Blake wrote:
> >> On 9/16/19 4:51 AM, Philippe Mathieu-Daud=E9 wrote:
> >>> While the tracing frawework does not forbid trailing newline in
> >>
> >> framework
> >>
> >>> events format string, using them lead to confuse output.
> >>> It is the responsibility of the backend to properly end an event
> >>> line.
> >>
> >> Why just trailing newline? Should we not forbid ALL use of newline in a
> >> trace message?
> >=20
> > I thought about it and forgot to add a comment when respining.
> > Yes, I think this is the right thing to enforce.
> > However it requires more cleanup, affecting more subsystems, so I'd
> > rather keep it for a follow-up series.
>=20
> What's the problem with using multi-line trace statements?

I agree with avoiding trailing newlines in format strings in the
=2E/trace-events files for consistency.

Although non-trailing newlines in format strings are unusual, they could
make trace logs easier to read in complex cases.  I don't see a reason
to forbid them since we support trace backends that emit a binary log
with a parsing API - there's no need to write scripts that parse the
text output.

> (I think I intentionally use these for AHCI in a few places.)

hw/ide/ahci.c format strings do not contain newlines, so they are
technically in compliance.

ahci_pretty_buffer_fis() is used to generate a hex dump with newlines
but it's a %s format string argument to trace_handle_reg_h2d_fis_dump()
and trace_handle_cmd_fis_dump().

Stefan

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2B9k8ACgkQnKSrs4Gr
c8hqWAf/RnInR82auwSupSQDRT2vFA5bCKX5AcArU2XQZ2zB2OCTFRp4vJbRSR7C
Z2XfVgOevBtAvh3DXbQZzdGae9X8T/ydUOuh71t+lPXu3+ay1cxrHts6Ew/cspnX
FCGqPleUO7qmY2M4ghx4NsWWsiM5GrIsNsDRVbHCbdQTNIIzSSnVwuOVuU2AzCer
FwaaT4uCeLD6nl2AzTEQEYQTao9kKyCWqbcnHjNDMgkfVHsYHIO5ykSRD9s2XZ9o
Ng3emCbHpjBAsABr+KrXT/ea4fTBQe2Mbrah9KkguQP+wvyJhznWqI1Ze2srEkqm
bink6m3D5g826Q+KRWmDooSX6QA2TQ==
=i3uT
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

