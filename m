Received: from eggs.gnu.org ([2001:4830:134:3::10]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzKeK-0004Yf-DE
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzKZM-0001Dt-G5
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:41:32 -0400
Received: from mail.ispras.ru ([83.149.199.45]:50676)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzKZM-0001DN-3t
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:41:28 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819516675.30857.9162557650483931182.stgit@pasha-ThinkPad-T60>
	<87mustz96w.fsf@linaro.org>
In-Reply-To: <87mustz96w.fsf@linaro.org>
Date: Mon, 10 Sep 2018 14:41:24 +0300
Message-ID: <001901d448fb$342c0bc0$9c842340$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/7] Add plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
>=20
> > This patch adds support for dynamically loaded plugins.
> > Every plugin is a dynamic library with a set of optional exported
> > functions that will be called from QEMU.
> >
> <snip>
> > +
> > +static QLIST_HEAD(, QemuPluginInfo) qemu_plugins
> > +                                =3D =
QLIST_HEAD_INITIALIZER(qemu_plugins);
> > +
> > +static QemuOptsList qemu_plugin_opts =3D {
> > +    .name =3D "plugin",
> > +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
> > +    .desc =3D {
> > +        {
> > +            .name =3D "file",
> > +            .type =3D QEMU_OPT_STRING,
> > +        },{
> > +            .name =3D "args",
> > +            .type =3D QEMU_OPT_STRING,
> > +        },
> > +        { /* end of list */ }
> > +    },
> > +};
> > +
> > +void qemu_plugin_parse_cmd_args(const char *optarg)
> > +{
> > +    QemuOpts *opts =3D qemu_opts_parse_noisily(&qemu_plugin_opts, =
optarg, false);
> > +    qemu_plugin_load(qemu_opt_get(opts, "file"),
> > +        qemu_opt_get(opts, "args"));
> > +}
>=20
> Currently this is only available to system mode emulation. Can it be
> extended to include linux-user as well?

Why not? I'm not familiar with linux-user, so I'll need some time to =
try.

Pavel Dovgalyuk
