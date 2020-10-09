Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE3BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FEA222BA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBz/evvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FEA222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQs95-0002nJ-7A
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQs87-0002Lm-EN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQs84-0005I2-EN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602248889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BEChPDmdKyIqgWjqOzSWDqjcTnvV+eCg9IRctV07YlM=;
 b=iBz/evvAzstqIlhKyQ+2nG7KhXIpPx0wiBGqUGEmCy1FJ7wX4AeS6oAp1UiIvV70jasEst
 TtnXrX7J8aMo5xseaKn3S9hfe0QYOd0z1JT6++VNKOLEKA00L0tYa+qY7h7zFcy4Y32TCA
 g9Tm3V0OwEOgMJ0i7kpR5kKjrQBXYoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-W3DlIiApO-ealP2rlZdYdg-1; Fri, 09 Oct 2020 09:07:54 -0400
X-MC-Unique: W3DlIiApO-ealP2rlZdYdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6516C805EF9;
 Fri,  9 Oct 2020 13:07:53 +0000 (UTC)
Received: from [10.3.113.14] (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 009956266E;
 Fri,  9 Oct 2020 13:07:52 +0000 (UTC)
Subject: Re: [PATCH 1/5] Fixing Lesser GPL version number [1/5]
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201009063734.2627-1-chetan4windows@gmail.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <9f236758-8039-0a16-df3a-b49b7e24168d@redhat.com>
Date: Fri, 9 Oct 2020 08:07:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009063734.2627-1-chetan4windows@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="99sRYPApiyvS8c83JO7WxjtLMtT2PZukY"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--99sRYPApiyvS8c83JO7WxjtLMtT2PZukY
Content-Type: multipart/mixed; boundary="C8NSZ1sJHhqNDOyxuJ2X2R7mDVjaxjlD2";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org
Message-ID: <9f236758-8039-0a16-df3a-b49b7e24168d@redhat.com>
Subject: Re: [PATCH 1/5] Fixing Lesser GPL version number [1/5]
References: <20201009063734.2627-1-chetan4windows@gmail.com>
In-Reply-To: <20201009063734.2627-1-chetan4windows@gmail.com>

--C8NSZ1sJHhqNDOyxuJ2X2R7mDVjaxjlD2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/9/20 1:37 AM, Chetan Pant wrote:

Thank you for contributing.  However, it will require more work before
this is ready to merge; while I have a lot of comments below, I hope you
read them in the intended tone of ideas on making your v2 better.  For
more thoughts on patch submission, see
https://wiki.qemu.org/Contribute/SubmitAPatch

Your message was not threaded with the other 4 patches, nor did you put
them in-reply-to a 0/5 cover letter.  This makes it harder to keep the
patches together in mail clients that sort by thread activity.

> There is no "version 2" of the "Lesser" General Public License. It is
> either "GPL version 2.0" or "Lesser GPL version 2.1". This patch replaces=
 all
> occurrences of "Lesser GPL version 2" with "Lesser GPL version 2.1" in co=
mment section.

I'm not a copyright lawyer; there may be legal ramifications for doing
this on files where you are not the copyright owner, although to me it
looks like an obvious correction of intent, so I'm okay with the idea.

Your subject line is awkward, for several reasons.  First, it does not
use imperative tense.  A handy rule of thumb: try mentally prepending
the phrase "apply this patch in order to..." in front of your git
commit; where the implied lead-in tends to make sense only if the
explicit text used imperative tense.  So in this case, you would do
s/Fixing/Fix/.  More comments below [1]

> Also, It came to notice that some of the files that were edited for the c=
hange

s/It/I/

> were not following latest comment rules. For example using "//" to mark c=
omment
> instead of "/*". That is also fixed in this patch.

When writing a commit message that starts with "Also," that is a strong
indication that you are fixing two distinct problems in one commit.
Don't fall for that temptation - logically separate changes should be
separate commits, as it makes review easier.  I had to go check in this
patch which file had the // comment change, but based on the diffstat
alone, none of them did, which makes it feel like this is a stale
copy-and-paste from one of your other commits in the series that merged
too much work into one commit.

>=20
> This patch is divided in 5 parts, directory wise, in order to make review=
ing process easier.
> Below listed are the parts of the patch, where asterisk denotes the part =
you are currently viewing.
>=20
> =09[*] Files in authz/backends/block/linux-user/tests/migration directory=
 (82 Files)
> =09[ ] Files in hw/include/disas (100 files)
> =09[ ] Files inside target/ 'alpha,arm,cris,hppa,i386' (96 files)
> =09[ ] Files inside target/ 'lm32,microblaze,mips,ppc,rx,sparc,tilegx,tri=
core,xtensa' (63 files)
> =09[ ] Files in ui/util/include/scripts and QEMU root directory (76 Files=
)

[1]Back to the topic of the commit subject.  A quick search of qemu.git
history shows that using a [1/5] designation is invention:

$ git shortlog | grep '\[[0-9]*/[0-9]*'
      tests/fp: enable f128_to_ui[32/64] tests in float-to-uint
      fpu: convert float[16/32/64]_squash_denormal to new modern style

But if you drop the [1/5] designation, then you would be submitting five
distinct patches with identical subjects, which is a backport nightmare.
 Better is to leave the patch ordering information in JUST the initial
[PATCH n/m] prefix (since that prefix is auto-stripped by git am), and
instead differentiate your subject lines with a topic.

Thus, maybe something like:

backends: Fix LGPL version number
disas: Fix LGPL version number
target: Fix LGPL version number

and so on.  There may be a smarter division of the work based on which
maintainer(s) will have to ack various patches; breaking the series into
more than 5 chunks may be easier, although it then requires more topic
lines.  Or, if it truly is automated, doing it all in one shot may be
best after all.

>=20
> Below is how the license version was corrected:
>=20
> 1. To find the number of file having "Lesser GPL version 2 ":
> =09grep -l Lesser $(grep -rl "version 2 " * ) > result.dat
>    Total of 417 files were found (After manually exluding the files like =
COPYING and COPYING.LIB from the result)

excluding

Long line; try to keep commit message bodies wrapped at column 72 or
less (since 'git log' displays them with indentation, and it is still
common to read git log in an 80-column window)

>=20
> 2. To find the number of occurences of "version 2 " in the resulted files=
:

occurrances

> =09egrep -c "version 2 " $(cat result.dat)
>    410 files had "version 2" occurence 1 time (name of those files was sa=
ved in one_timers.dat)
>    and in 7 files "version 2" occurences were multiple times.
>=20
> 3. Files having occurence exactly 1 time were corrected using below comma=
nd:

three more of the same typo

> =09sed -i "s/version 2 /version 2.1 /g" $(cat one_timers.dat)
>    For rest of 7 files, correction was done manually.
>=20
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---

I did not actually inspect the generated changes to see if they all look
reasonable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--C8NSZ1sJHhqNDOyxuJ2X2R7mDVjaxjlD2--

--99sRYPApiyvS8c83JO7WxjtLMtT2PZukY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl+AYKgACgkQp6FrSiUn
Q2rAxQf/Q6GKfiWnVFqPs/6+UOvXXQ7xWxqxxMqTilzpS5BNPKTNpJsxtYXMrZkU
UPlv476X49yQgJwm5NPg1eBPQ+F1DW+z1lPGTZdQ2EcNcKECg+nBK0gBxRkJdcVz
fBhuuZQvxPwMwfoAHKLgdDSX6EMr7uyXvkNRVwwDJ/pmIxEBi7nDmNsV/vfUtu+2
jYMHGUDVhIq3gf0j1vKJ9wOA4L2WrxyidxiDB4CM6++BZwE3PvtMS4VS3XFzO8zi
9Jz2tTgpt7ReaYcYBVLGGie9Kk5u0kaSenDQsJYDVitjmT9+U6Sc99eY5nDA80tW
fmpGIVm3LiIMO+dS1bV3yktHAXELZg==
=MxNT
-----END PGP SIGNATURE-----

--99sRYPApiyvS8c83JO7WxjtLMtT2PZukY--


