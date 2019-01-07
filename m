Received: from eggs.gnu.org ([209.51.188.92]:55804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggYCb-00085p-3C
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggYCY-0002pU-Cz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:56:36 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggYCY-0002gP-1M
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:56:34 -0500
Received: by mail-oi1-x234.google.com with SMTP id y23so883044oia.4
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20190107122304.22997-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190107122304.22997-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 16:56:17 +0000
Message-ID: <CAFEAcA_MrBuqKD+4rBmiQ_0Q8qc4q3Wb1FfDu=Q_r69P8bNVmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/28] Machine props patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 7 Jan 2019 at 12:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3f=
b8:
>
>   Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-=
request' into staging (2019-01-04 18:23:13 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/machine-props-pull-request
>
> for you to fetch changes up to fa0cb34d2210cc749b9a70db99bb41c56ad20831:
>
>   hostmem: use object id for memory region name with >=3D 4.0 (2019-01-07=
 16:18:42 +0400)
>
> ----------------------------------------------------------------
> Generalize machine compatibility properties
>
> During "[PATCH v2 05/10] qom/globals: generalize
> object_property_set_globals()" review, Eduardo suggested to rework the
> GlobalProperty handling, so that -global is limited to QDev only and
> we avoid mixing the machine compats and the user-provided -global
> properties (instead of generalizing -global to various object kinds,
> like I proposed in v2).
>
> "qdev: do not mix compat props with global props" patch decouples a
> bit user-provided -global from machine compat properties. This allows
> to get rid of "user_provided" and "errp" fields in following patches.
>
> A new compat property "x-use-canonical-path-for-ramblock-id" is added
> to hostmem for legacy canonical path names, set to true for -file and
> -memfd with qemu < 4.0.
>
> (this series was initially titled "[PATCH v2 00/10] hostmem: use
> object "id" for memory region name with >=3D 3.1", but its focus is more
> in refactoring the global and compatilibity properties handling now)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
