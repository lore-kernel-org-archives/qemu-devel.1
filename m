Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73CEC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A219E20650
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pru59rde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A219E20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNn8-0008FT-Ub
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNbw-0005S6-6Z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNbt-0006Vb-4d
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:52:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNbs-0006UU-VT
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjbZZYgtnQ7GjQvsvvD6Awt3fSHHSqwfwpB/LRa2+x4=;
 b=Pru59rdeFZqamOcMaVH8YQwG1RPXbP3dOP38ZpQGm+LXOtoaRaRALq/UsIgTLeYjpdu562
 BKj0RiF56vlNQK1tIt3XBC2ssFM7H7C0LBPx22KAVraxCdxY+84ZuhGLNlHTdweTgjgiGc
 4c84Xl19Zk9zBZolgc6lMuhO1xtgoPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-W1ASQOM2Pi6AC0DWfpmssQ-1; Wed, 06 Nov 2019 10:52:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1673A477;
 Wed,  6 Nov 2019 15:52:38 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D414E5DA7C;
 Wed,  6 Nov 2019 15:52:34 +0000 (UTC)
Message-ID: <ad34d3acd88953e49f79b7beb3ebb64922b5529e.camel@redhat.com>
Subject: Re: [PATCH v2 21/21] iotests: Allow check -o data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:52:33 +0200
In-Reply-To: <20191015142729.18123-22-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-22-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: W1ASQOM2Pi6AC0DWfpmssQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> The problem with allowing the data_file option is that you want to use a
> different data file per image used in the test.  Therefore, we need to
> allow patterns like -o data_file=3D'$TEST_IMG.data_file'.
>=20
> Then, we need to filter it out from qemu-img map, qemu-img create, and
> remove the data file in _rm_test_img.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.filter | 23 +++++++++++++++++++++--
>  tests/qemu-iotests/common.rc     | 22 +++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
> index 63bc6f6f26..9dd05689d1 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -121,7 +121,13 @@ _filter_actual_image_size()
>  # replace driver-specific options in the "Formatting..." line
>  _filter_img_create()
>  {
> -    $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
> +    data_file_filter=3D()
> +    if data_file=3D$(_get_data_file "$TEST_IMG"); then
> +        data_file_filter=3D(-e "s# data_file=3D$data_file##")
> +    fi
> +
> +    $SED "${data_file_filter[@]}" \
> +        -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
> @@ -204,9 +210,22 @@ _filter_img_info()
>  # human and json output
>  _filter_qemu_img_map()
>  {
> +    # Assuming the data_file value in $IMGOPTS contains a '$TEST_IMG',
> +    # create a filter that replaces the data file name by $TEST_IMG.
> +    # Example:
> +    #   In $IMGOPTS: 'data_file=3D$TEST_IMG.data_file'
> +    #   Then data_file_pattern =3D=3D '\(.*\).data_file'
> +    #   And  data_file_filter  =3D=3D -e 's#\(.*\).data_file#\1#
> +    data_file_filter=3D()
> +    if data_file_pattern=3D$(_get_data_file '\\(.*\\)'); then
> +        data_file_filter=3D(-e "s#$data_file_pattern#\\1#")
> +    fi
> +
>      $SED -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
>          -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
> -        -e 's/Mapped to *//' | _filter_testdir | _filter_imgfmt
> +        -e 's/Mapped to *//' \
> +        "${data_file_filter[@]}" \
> +        | _filter_testdir | _filter_imgfmt
>  }
> =20
>  _filter_nbd()
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index f3784077de..bed789a691 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -277,6 +277,20 @@ _stop_nbd_server()
>      fi
>  }
> =20
> +# Gets the data_file value from IMGOPTS and replaces the '$TEST_IMG'
> +# pattern by '$1'
> +# Caution: The replacement is done with sed, so $1 must be escaped
> +#          properly.  (The delimiter is '#'.)
> +_get_data_file()
> +{
> +    if ! echo "$IMGOPTS" | grep -q 'data_file=3D'; then
> +        return 1
> +    fi
> +
> +    echo "$IMGOPTS" | sed -e 's/.*data_file=3D\([^,]*\).*/\1/' \
> +                    | sed -e "s#\\\$TEST_IMG#$1#"
> +}
> +
>  _make_test_img()
>  {
>      # extra qemu-img options can be added by tests
> @@ -297,7 +311,8 @@ _make_test_img()
>      fi
> =20
>      if [ -n "$IMGOPTS" ]; then
> -        optstr=3D$(_optstr_add "$optstr" "$IMGOPTS")
> +        imgopts_expanded=3D$(echo "$IMGOPTS" | sed -e "s#\\\$TEST_IMG#$i=
mg_name#")
> +        optstr=3D$(_optstr_add "$optstr" "$imgopts_expanded")
>      fi
>      if [ -n "$IMGKEYSECRET" ]; then
>          object_options=3D"--object secret,id=3Dkeysec0,data=3D$IMGKEYSEC=
RET"
> @@ -376,6 +391,11 @@ _rm_test_img()
>          # Remove all the extents for vmdk
>          "$QEMU_IMG" info "$img" 2>/dev/null | grep 'filename:' | cut -f =
2 -d: \
>              | xargs -I {} rm -f "{}"
> +    elif [ "$IMGFMT" =3D "qcow2" ]; then
> +        # Remove external data file
> +        if data_file=3D$(_get_data_file "$img"); then
> +            rm -f "$data_file"
> +        fi
>      fi
>      rm -f "$img"
>  }


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


