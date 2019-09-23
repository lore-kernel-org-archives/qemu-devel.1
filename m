Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A784C00043
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 21:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F65621971
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 21:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F65621971
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCVVZ-0005lw-5v
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 17:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCVIt-0004Hy-3o
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 16:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCVIr-0002By-56
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 16:51:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iCVIl-0002AD-Ak; Mon, 23 Sep 2019 16:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EA7A3064FD1;
 Mon, 23 Sep 2019 20:51:17 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B505D721;
 Mon, 23 Sep 2019 20:51:16 +0000 (UTC)
Date: Mon, 23 Sep 2019 16:51:15 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 04/16] tests/docker: reduce scary warnings from failed
 inspect
Message-ID: <20190923205115.GE6528@dhcp-17-179.bos.redhat.com>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190919171015.12681-5-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 23 Sep 2019 20:51:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 06:10:03PM +0100, Alex Benn=E9e wrote:
> There is a race here in the clean-up code so lets just accept that
> sometimes the active task we just looked up might have finished before
> we got to inspect it.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 29613afd489..4dca6006d2f 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -235,20 +235,24 @@ class Docker(object):
>          if not only_active:
>              cmd.append("-a")
>          for i in self._output(cmd).split():
> -            resp =3D self._output(["inspect", i])
> -            labels =3D json.loads(resp)[0]["Config"]["Labels"]
> -            active =3D json.loads(resp)[0]["State"]["Running"]
> -            if not labels:
> -                continue
> -            instance_uuid =3D labels.get("com.qemu.instance.uuid", Non=
e)
> -            if not instance_uuid:
> -                continue
> -            if only_known and instance_uuid not in self._instances:
> -                continue
> -            print("Terminating", i)
> -            if active:
> -                self._do(["kill", i])
> -            self._do(["rm", i])
> +            try:
> +                resp =3D self._output(["inspect", i])
> +                labels =3D json.loads(resp)[0]["Config"]["Labels"]
> +                active =3D json.loads(resp)[0]["State"]["Running"]
> +                if not labels:
> +                    continue
> +                instance_uuid =3D labels.get("com.qemu.instance.uuid",=
 None)
> +                if not instance_uuid:
> +                    continue
> +                if only_known and instance_uuid not in self._instances=
:
> +                    continue
> +                print("Terminating", i)
> +                if active:
> +                    self._do(["kill", i])
> +                    self._do(["rm", i])

Both podman and docker seem to handle "rm -f $INSTANCE" well, which
would by itself consolidate the two commands in one and minimize the
race condition.

For unexisting containers, and no other errors, podman will return "1
if one of the specified containers did not exist, and no other
failure", as per its man page.  I couldn't find any guarantee that
docker will also return 1 on a similar situation, but that's what
I've experienced too:

 $ docker rm -f CONTAINER_IS_NOW_FONE
 Error response from daemon: No such container: CONTAINER_IS_NOW_GONE
 $ echo $?
 1

Maybe waiving exit status 1 and nothing else would do the trick here
and not hide other real problems?

- Cleber.

> +            except subprocess.CalledProcessError:
> +                # i likely finished running before we got here
> +                pass
> =20
>      def clean(self):
>          self._do_kill_instances(False, False)
> --=20
> 2.20.1
>=20
>=20

