Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F36820760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA0RS/1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F36820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiuAd-0005Mj-E7
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiu9E-0004EF-5J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:23:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiu9D-0005Bl-52
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591770218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+LdaBlvV7QVZBoQ97pyzjhB++WdnE0775qQ3p24oCs=;
 b=UA0RS/1B8zvC1HdttAc4PhBPTcaoEnsmZ+M59kkSsC9nrZpmqyrLENRGTmewEh8BUSzAf5
 IRp3BXWTtEarM2X1FaN3czQVHuJ1rXtykyv82fUH+Zfh6jXG7bt/l808fj3Q8ep6C/bmK4
 8vYDoH9AFy2biYjIxUUfHPyT4umEzss=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-lmlHXYxIPXWTBqc0iJWaTw-1; Wed, 10 Jun 2020 02:23:34 -0400
X-MC-Unique: lmlHXYxIPXWTBqc0iJWaTw-1
Received: by mail-wm1-f69.google.com with SMTP id b65so149063wmb.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 23:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=n9Z7kiud+AyxjNeYaLB2tWGySZgxjKvSHRLNXMJZQVs=;
 b=r3QYkqIWdSxQ7B7gQHwJfKCSUrq680gN1osSI1T5LmQOZ88WJ9sKdDHNLbBEvosgvC
 gzvPt+EeSpGkoVN1qe3cZ4Nsn0i+3Coc69A8XnbkzEm116HU2lDJ25SdEPk5+GqfqzX7
 8Ft9auG/jByl2dCvY8+VmetGJq7ausSLtTzdee7jP+uKz2+LK+9PNfsx84IHfuPh+fti
 OcjGun9ow+CJbr2YLTPCjrH8ylqBXstL72Tt60waIpinEDpW4PuoIxTnl3DJyDTJL5m4
 m6GQhue6jby9eyw56Lq1CnB7TVZpK85/toYY2X5ZxJ2dmNR12cn0pcHHAlBWXIJTXkpI
 eqjQ==
X-Gm-Message-State: AOAM530fKa15OZ+fC//Fl6s44uBTeLy2iE4fedZCvGZWoI8wqqHoZrTA
 QCS3A5Pmjxej0whpUM2vrEoAG1EpXOUogkAmuHw4UvOMEBRoIS3ZLgkOoW3oLGl/wlrk4cNju4v
 OPE2jJx8QlmBaFgg=
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr1700289wrs.209.1591770212907; 
 Tue, 09 Jun 2020 23:23:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZRffoAD50wAFcIx4bAmGONfGtwZyXB3Y9U0t4YD/Jm6qkb2AZ7VTzYMVQL/ZEeSWI64QsRg==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr1700269wrs.209.1591770212665; 
 Tue, 09 Jun 2020 23:23:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d?
 ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
 by smtp.gmail.com with ESMTPSA id z25sm5567453wmf.10.2020.06.09.23.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 23:23:31 -0700 (PDT)
Subject: Re: [PATCH 0/9] AMD SEV: Cleanup state handling
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
 <d9b13bf3-2b72-1a13-d3c1-2e31c411e236@redhat.com>
 <20200610050413.GL494336@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b963a08e-1015-3e66-87e3-2dcb15b02104@redhat.com>
Date: Wed, 10 Jun 2020 08:23:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200610050413.GL494336@umbus.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I0O1pF9fFh5HgtLGrgjC2vvHEUymis4id"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, ekabkost@redhat.com,
 philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I0O1pF9fFh5HgtLGrgjC2vvHEUymis4id
Content-Type: multipart/mixed; boundary="t9J8MQTB8A0DiPOegrdjrFT9dRhAfHipe"

--t9J8MQTB8A0DiPOegrdjrFT9dRhAfHipe
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/06/20 07:04, David Gibson wrote:
>>>  target/i386/sev.c      | 257 +++++++++++++++++++++++------------------
>>>  target/i386/sev_i386.h |  49 --------
>>>  2 files changed, 143 insertions(+), 163 deletions(-)
>> Queued, thanks.
> Do you have a best guess at when these might merge?  I have another
> series based on this one I'd like to move forward with.

Sorry, I am seeing a hang with my pull request that I have had issues
bisecting.

Paolo


--t9J8MQTB8A0DiPOegrdjrFT9dRhAfHipe--

--I0O1pF9fFh5HgtLGrgjC2vvHEUymis4id
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl7gfGEACgkQv/vSX3jH
roPZSAgAj6cWnj4cvnltqbJimUqrseyEJk0GG1uUkYbl3yH6tTt3VpLWeb2i5Qmv
phMuxYATrkE29MMOHBESnDtarXNahm8zOa7lUaicjiN3vAfj0mNf4RjvjacfS/ZM
AoCq/sbbi8hHhxVN0tnLY2DQcxEY4KcvIw+nCsNfWGccXVWfVTX9UhjEsBvfWvD1
86Cv6Vr06IUyOWdtcHJ15bQk94k/9YXwS5CJyLToNJe05IsAuvk7+33jdIppTHyl
OvyHoxJP8N7jCXEcQ0Lo7uUff+sQq2RTkXVsysC6o0WdU4jF60HElTh63Rol8qh1
YJAbvz8tJVXG7whKe7PLLjGamzV6mQ==
=c0pY
-----END PGP SIGNATURE-----

--I0O1pF9fFh5HgtLGrgjC2vvHEUymis4id--


