Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EDC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EEC22248
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+45huIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EEC22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5M6-000062-Az
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5A5-0004vI-ES
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT59z-0006dr-MN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602775633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NypknWblX2TVvVVqDR927dGMc29ogSTjLV49LWqbJ5I=;
 b=K+45huIlFZ5tTNRKPPqWEyS0IR55l8PZJD5hShLVZzIrPzGDVV8zCEhvRFU7ylYyU3tlUg
 InQgyLWxfztvOfuQtdMLvn7wvab5Y8NtiOglFF/mPYrFfFlI/W2mvVfzUkpk71hcFpkP9j
 TnnHA+sEJ1SFRjsHoR10PDyQT8gOJs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-kIDC7uKjNzy-w4m3MhsTvg-1; Thu, 15 Oct 2020 11:27:11 -0400
X-MC-Unique: kIDC7uKjNzy-w4m3MhsTvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 439671084D63;
 Thu, 15 Oct 2020 15:27:10 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3C545D9E8;
 Thu, 15 Oct 2020 15:27:05 +0000 (UTC)
Subject: Re: [PATCH v2 18/20] iotests: Allow testing FUSE exports
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-19-mreitz@redhat.com>
 <20201015114319.GF4610@merkur.fritz.box>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <941645ba-0451-abfa-6ca3-42c3e49c9dd6@redhat.com>
Date: Thu, 15 Oct 2020 17:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015114319.GF4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a3rKZrtbbK4GbmlbXHWXJTDZviCTgIrVo"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a3rKZrtbbK4GbmlbXHWXJTDZviCTgIrVo
Content-Type: multipart/mixed; boundary="y1EuWCzoI6QmHAIeVnNqeqGOp5yGyCxuu"

--y1EuWCzoI6QmHAIeVnNqeqGOp5yGyCxuu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 13:43, Kevin Wolf wrote:
> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>> This pretends FUSE exports are a kind of protocol.  As such, they are
>> always tested under the format node.  This is probably the best way to
>> test them, actually, because this will generate more I/O load and more
>> varied patterns.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/check         |   6 ++
>>  tests/qemu-iotests/common.filter |   5 +-
>>  tests/qemu-iotests/common.rc     | 124 +++++++++++++++++++++++++++++++
>>  3 files changed, 134 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 467a7cf1b7..07232138d7 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -270,6 +270,7 @@ image protocol options
>>      -rbd                test rbd
>>      -sheepdog           test sheepdog
>>      -nbd                test nbd
>> +    -fuse               test fuse
>>      -ssh                test ssh
>>      -nfs                test nfs
>> =20
>> @@ -382,6 +383,11 @@ testlist options
>>              xpand=3Dfalse
>>              ;;
>> =20
>> +        -fuse)
>> +            IMGPROTO=3Dfuse
>> +            xpand=3Dfalse
>> +            ;;
>> +
>>          -ssh)
>>              IMGPROTO=3Dssh
>>              xpand=3Dfalse
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/commo=
n.filter
>> index 838ed15793..172ea5752e 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -44,7 +44,8 @@ _filter_qom_path()
>>  _filter_testdir()
>>  {
>>      $SED -e "s#$TEST_DIR/#TEST_DIR/#g" \
>> -         -e "s#$SOCK_DIR/#SOCK_DIR/#g"
>> +         -e "s#$SOCK_DIR/#SOCK_DIR/#g" \
>> +         -e "s#SOCK_DIR/fuse-#TEST_DIR/#g"
>>  }
>> =20
>>  # replace occurrences of the actual IMGFMT value with IMGFMT
>> @@ -127,6 +128,7 @@ _filter_img_create_filenames()
>>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$SOCK_DIR#SOCK_DIR#g" \
>> +        -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
>>          -e "s#$IMGFMT#IMGFMT#g" \
>>          -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
>>          -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
>> @@ -227,6 +229,7 @@ _filter_img_info()
>>          -e "s#$IMGFMT#IMGFMT#g" \
>>          -e 's#nbd://127.0.0.1:[0-9]\\+$#TEST_DIR/t.IMGFMT#g' \
>>          -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'=
 \
>> +        -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
>>          -e "/encrypted: yes/d" \
>>          -e "/cluster_size: [0-9]\\+/d" \
>>          -e "/table_size: [0-9]\\+/d" \
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index e4751d4985..e17f813f06 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -257,6 +257,9 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>>          TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix"
>>          TEST_IMG=3D"$TEST_IMG,file.path=3D$SOCK_DIR/nbd"
>> +    elif [ "$IMGPROTO" =3D "fuse" ]; then
>> +        TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>> +        TEST_IMG=3D"$DRIVER,file.filename=3D$SOCK_DIR/fuse-t.$IMGFMT"
>>      elif [ "$IMGPROTO" =3D "ssh" ]; then
>>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>>          TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,fil=
e.path=3D$TEST_IMG_FILE"
>> @@ -273,6 +276,9 @@ else
>>      elif [ "$IMGPROTO" =3D "nbd" ]; then
>>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>>          TEST_IMG=3D"nbd+unix:///?socket=3D$SOCK_DIR/nbd"
>> +    elif [ "$IMGPROTO" =3D "fuse" ]; then
>> +        TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>> +        TEST_IMG=3D"$SOCK_DIR/fuse-t.$IMGFMT"
>>      elif [ "$IMGPROTO" =3D "ssh" ]; then
>>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>>          REMOTE_TEST_DIR=3D"ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\=
)\\?$TEST_DIR"
>> @@ -288,6 +294,9 @@ fi
>>  ORIG_TEST_IMG_FILE=3D$TEST_IMG_FILE
>>  ORIG_TEST_IMG=3D"$TEST_IMG"
>> =20
>> +FUSE_PIDS=3D()
>> +FUSE_EXPORTS=3D()
>> +
>>  if [ -z "$TEST_DIR" ]; then
>>          TEST_DIR=3D$PWD/scratch
>>  fi
>> @@ -357,6 +366,10 @@ _test_img_to_test_img_file()
>>              echo "$1"
>>              ;;
>> =20
>> +        fuse)
>> +            echo "$1" | sed -e "s#$SOCK_DIR/fuse-#$TEST_DIR/#"
>> +            ;;
>> +
>>          nfs)
>>              echo "$1" | sed -e "s#nfs://127.0.0.1##"
>>              ;;
>> @@ -385,6 +398,11 @@ _make_test_img()
>>      local opts_param=3Dfalse
>>      local misc_params=3D()
>> =20
>> +    if [[ $IMGPROTO =3D=3D fuse && $TEST_IMG =3D=3D $SOCK_DIR/fuse-* ]]=
; then
>=20
> Given that you sent this series, I assume the test cases pass, but I
> don't understand how this works with more than one image. Shouldn't you
> get an syntax error then because $SOCK_DIR/fuse-* will evaluate to
> multiple words?

Note the [[ ]] =E2=80=93 this is a bash condition.  You can do pattern matc=
hing
within them, as you see here.  =E2=80=9C$TEST_IMG =3D=3D $SOCK_DIR/fuse-*=
=E2=80=9D checks
whether $TEST_IMG matches the glob pattern given as the second operand.

>> +        # The caller may be trying to overwrite an existing image
>> +        _rm_test_img "$TEST_IMG"
>> +    fi
>> +
>>      if [ -z "$TEST_IMG_FILE" ]; then
>>          img_name=3D$TEST_IMG
>>      elif [ "$IMGOPTSSYNTAX" !=3D "true" -a \
>> @@ -469,11 +487,105 @@ _make_test_img()
>>          eval "$QEMU_NBD -v -t -k '$SOCK_DIR/nbd' -f $IMGFMT -e 42 -x ''=
 $TEST_IMG_FILE >/dev/null &"
>>          sleep 1 # FIXME: qemu-nbd needs to be listening before we conti=
nue
>>      fi
>> +
>> +    if [ $IMGPROTO =3D "fuse" -a -f "$img_name" ]; then
>> +        local export_mp
>> +        local pid
>> +        local pidfile
>> +        local timeout
>> +
>> +        export_mp=3D$(echo "$img_name" | sed -e "s#$TEST_DIR/#$SOCK_DIR=
/fuse-#")
>> +        if ! echo "$export_mp" | grep -q "^$SOCK_DIR"; then
>> +            echo 'Cannot use FUSE exports with images outside of TEST_D=
IR' >&2
>> +            return 1
>> +        fi
>> +
>> +        touch "$export_mp"
>> +        rm -f "$SOCK_DIR/fuse-output"
>> +
>> +        # Usually, users would export formatted nodes.  But we present =
fuse as a
>> +        # protocol-level driver here, so we have to leave the format to=
 the
>> +        # client.
>> +        QEMU_STGD_NEED_PID=3Dy $QEMU_STGD \
>> +              --blockdev file,node-name=3Dexport-node,filename=3D$img_n=
ame,discard=3Dunmap \
>> +              --export fuse,id=3Dfuse-export,node-name=3Dexport-node,mo=
untpoint=3D"$export_mp",writable=3Don,growable=3Don \
>> +              &
>> +
>> +        pidfile=3D"$QEMU_TEST_DIR/qemu-storage-daemon.pid"
>> +
>> +        # Wait for the PID file
>> +        while [ ! -f "$pidfile" ]; do
>> +            sleep 0.5
>> +        done
>> +
>> +        pid=3D$(cat "$pidfile")
>> +        rm -f "$pidfile"
>> +
>> +        FUSE_PIDS+=3D($pid)
>> +        FUSE_EXPORTS+=3D("$export_mp")
>> +    fi
>>  }
>> =20
>>  _rm_test_img()
>>  {
>>      local img=3D$1
>> +
>> +    if [[ $IMGPROTO =3D=3D fuse && $img =3D=3D $SOCK_DIR/fuse-* ]]; the=
n
>> +        # Drop a FUSE export
>> +        local df_output
>> +        local i
>> +        local image_file
>> +        local index=3D''
>> +        local timeout
>> +
>> +        for i in "${!FUSE_EXPORTS[@]}"; do
>> +            if [ "${FUSE_EXPORTS[i]}" =3D "$img" ]; then
>> +                index=3D$i
>> +                break
>> +            fi
>> +        done
>> +
>> +        if [ -z "$index" ]; then
>> +            # Probably gone already
>> +            return 0
>> +        fi
>> +
>> +        kill "${FUSE_PIDS[index]}"
>> +
>> +        # Wait until the mount is gone
>> +        timeout=3D10 # *0.5 s
>> +        while true; do
>> +            # Will show the mount point; if the mount is still there,
>> +            # it will be $img.
>> +            df_output=3D$(df -T "$img" 2>/dev/null)
>=20
> 'df -T' doesn't seem to be portable.
>=20
> Well, neither is FUSE, so I guess it doesn't matter?

What a nice coincidence. :)

Though then again I have no idea what the -T is for, I don=E2=80=99t grep
anywhere for =E2=80=9Cfuse=E2=80=9D, so we can just drop that -T.

Max

>> +
>> +            # But df may also show an error ("Transpoint endpoint not
>> +            # connected"), so retry in such cases
>> +            if [ -n "$df_output" ]; then
>> +                if ! echo "$df_output" | grep -q "$img"; then
>> +                    break
>> +                fi
>> +            fi
>> +
>> +            sleep 0.5
>> +
>> +            timeout=3D$((timeout - 1))
>> +            if [ "$timeout" =3D 0 ]; then
>> +                echo 'Failed to take down FUSE export' >&2
>> +                return 1
>> +            fi
>> +        done
>> +
>> +        rm -f "$img"
>> +
>> +        unset "FUSE_PIDS[$index]"
>> +        unset "FUSE_EXPORTS[$index]"
>> +
>> +        image_file=3D$(echo "$img" | sed -e "s#$SOCK_DIR/fuse-#$TEST_DI=
R/#")
>> +        _rm_test_img "$image_file"
>> +        return
>> +    fi
>> +
>>      if [ "$IMGFMT" =3D "vmdk" ]; then
>>          # Remove all the extents for vmdk
>>          "$QEMU_IMG" info "$img" 2>/dev/null | grep 'filename:' | cut -f=
 2 -d: \
>=20
> Kevin
>=20



--y1EuWCzoI6QmHAIeVnNqeqGOp5yGyCxuu--

--a3rKZrtbbK4GbmlbXHWXJTDZviCTgIrVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IakcACgkQ9AfbAGHV
z0D98Qf/YlYwArdWlIkXoBx+lm3/GNcvfD1QS/97F99FL+bMkn2Pvx1nuVxAAksU
VOpK72yqlSn7pUoA+a4BqLshcWMPAfKg7U7aAQ0NIjSg8EAwniJrWPRYCG9Ke3wU
l/X+LSIw+FqeWJnjGekl7/50nfZIW6rB/hkSEvgPtuAunZ58KxQyUU3hLojsvB8E
ifJmY2iGHBGQGzKpT9zH7Ky3fkT1jOnqywVNHFBm7JEQ00n3/E3iR3xW+FPxBFO4
AUG76IkLmhifdVLL0JxQmZrKW0yRS/XoPDAIzTa/Ap4jlN9P0mkFLxpTvn0i38t7
n+/svh6W6kxg23Y4UyxlCTlRQKg33w==
=aS/B
-----END PGP SIGNATURE-----

--a3rKZrtbbK4GbmlbXHWXJTDZviCTgIrVo--


