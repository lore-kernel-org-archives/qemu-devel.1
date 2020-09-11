Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9B5C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC30821D91
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/0Ch/My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC30821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGh56-0001j9-Lr
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGh3g-0000XI-CW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:17:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGh3e-0007Uh-BK
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599823053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZYiL9xoL5YpDBXhKr9up61jwGQ4DN3Y0WtxNVoAiAc=;
 b=U/0Ch/MyMD9HPqhskR/pZEKmW7UaSEByME//mdg0GkPEOWKNVN/2PwxoE7Z+Qz12ieTBYL
 XF7/iHcePO+JWzpRBaUxoqI8j2+L5p9EAF/oTpAyIuoXTWo4+yD2mg0Va8d3wSDps4FZj1
 HM6RO2S2v7kW3BCCHu31UjfzLDjkXik=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-1DXI6NU9NZSQ0DTTTVkv_A-1; Fri, 11 Sep 2020 07:17:31 -0400
X-MC-Unique: 1DXI6NU9NZSQ0DTTTVkv_A-1
Received: by mail-ed1-f71.google.com with SMTP id c3so4081667edm.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 04:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=kXDTQi6TDLJLooYlkyhQHSjqq5IDcVW6kLZcIWS93T0=;
 b=YhVcWLkhNtqUomxxzmAVViyxhiisrvBT6HgZPFdvgvAZX24VMMHqVpra93Cj787KRp
 eL+jelrQ8qzYq+Nwa+1xgik2LAgXpTNU/9lH2aknFdVPOn2PgBiOd00znz6ON4J+wY+0
 NdlotHWwKSbfjF+Lp4qMrF97+CSG56ZEshXAxm+4v+SU7F2lmJAJ1x3v1ESizk8kJZ1h
 NtbzYRuabT3bb/9u1cUNHYEihcTusfJU1FiiDeKT+BqzWp16wHiNQXJINp6O7LlRSWIY
 36q5Qj93SwXVOrgxR/gGYP7UyZxGAahWpty576yzSyhM9Gw063SzMN6LlHo1lta7+V9a
 MmnQ==
X-Gm-Message-State: AOAM531izsTSwsAV3ssW0KyUop4RPPRc5BdsetKLgx5mLnEx8LwgdGS6
 IDIuhW9MeZ1b9xj60r1ps98HLH7cSsR64OBTj/6GHSV8QnTju2HAWTkP+u/3fVcVsFWH6JLHqkn
 jhwADe3lG0BDcekI=
X-Received: by 2002:a50:f1d1:: with SMTP id y17mr1335282edl.231.1599823049478; 
 Fri, 11 Sep 2020 04:17:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM7jwCd749CneQy1W6heVHQO0KIeI6wgAo4GPI3t980YZfNjnSqmwtTU+f9nTJfwi4zWAgpg==
X-Received: by 2002:a50:f1d1:: with SMTP id y17mr1335260edl.231.1599823049282; 
 Fri, 11 Sep 2020 04:17:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6?
 ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id g11sm1383789edt.88.2020.09.11.04.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 04:17:28 -0700 (PDT)
Subject: Re: [PULL v2 01/46] qemu-iotests: move check-block back to Makefiles
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200906175344.5042-1-pbonzini@redhat.com>
 <20200906175344.5042-2-pbonzini@redhat.com>
 <98f7869a-cb45-08b5-670a-ebc47254b0c2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3176e443-5da6-8d6e-fa61-e2b3ccef7f30@redhat.com>
Date: Fri, 11 Sep 2020 13:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <98f7869a-cb45-08b5-670a-ebc47254b0c2@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2WpTvwKj1EU7jMnV4oAPCkswvHfGaT84g"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2WpTvwKj1EU7jMnV4oAPCkswvHfGaT84g
Content-Type: multipart/mixed; boundary="xsoOqTGwwroSzDHgX7GGHXeyU8uu154rE"

--xsoOqTGwwroSzDHgX7GGHXeyU8uu154rE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/09/20 12:58, Max Reitz wrote:
> It seems like the socket_scm_helper is now only built as a dependency of
> check-block, instead of all the time.  That=E2=80=99s a bit of a shame.
> (The obvious workaround of course is to specifically build the
> socket_scm_helper, but that doesn=E2=80=99t seem right.)

Or just remove the build_by_default: false here:

    socket_scm_helper =3D executable('socket_scm_helper', 'socket_scm_helpe=
r.c',
                                    build_by_default: false)


I guess now is a good time to decide which executables to build by
default (static_libraries should never be built by default) and
document it in docs/devel/build-system.rst.

Right now, the only executables that aren't built by default are:

- rdmacm-mux and vhost-user-blk because they're broken

- gen-features because it's built anyway for s390 targets

- vhost-user-bridge, and that probably should be changed

- socket_scm_helper, which could/should be changed too

- fptest, not sure why that works at all O:-)  Tests are built by
default (and they trigger coverity quite a bit).  We will be
able to fix that, and at the same time respect the "tests(depends: ...)"
argument instead of just having "check: all", when meson 0.56.0
comes out.

Paolo


--xsoOqTGwwroSzDHgX7GGHXeyU8uu154rE--

--2WpTvwKj1EU7jMnV4oAPCkswvHfGaT84g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl9bXMkACgkQv/vSX3jH
roPUPAf/X8Yg46g27YtJLXm+4LP3tQVOYbY8SyxhhnJlLRKBeYQIQMO8eLCnR3qX
nnObSQ9RmhHBAm4RRN1PLbJpOOjWDWjlWrYSs1nES8vOL6Gnr1v4VXz5avL9Ctum
5UOeWqOuw5i3wgSASIBgHZwq8Dz4odB01etPWHG0ZzzghrqsH9/3ghquWeP4N5M8
1ruGb4/YwiWkLyrTpXhBpCpcTl32itY2aPqhLElI3dCUPwdWWINozIkfxJC+Y1LP
aTFItSBOqUwp1qbD2pfIx/qnOTeuM+Pde8bGAD6A/ShPf1xF51S3bQYHMPXgwMzN
D8lBzzXuPSo7CptMcKUa3aFsWvlP7Q==
=ccl3
-----END PGP SIGNATURE-----

--2WpTvwKj1EU7jMnV4oAPCkswvHfGaT84g--


