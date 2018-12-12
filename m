Received: from eggs.gnu.org ([2001:4830:134:3::10]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX1pO-0005L2-Ui
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX1pK-0005YA-V6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:33:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gX1pK-0005X5-MC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:33:14 -0500
Date: Wed, 12 Dec 2018 10:33:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181212103308.GA31033@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181212102548.27626-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212102548.27626-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, maxim.kuvyrkov@linaro.org

On Wed, Dec 12, 2018 at 10:25:48AM +0000, Alex Benn=C3=A9e wrote:
> This is a QEMU specific version of a gitdm config for generating
> reports on the contributor base of the project. I've added enough
> group maps and domain aliases to ensure the current top ten is as
> reflective as it can be. As of this commit running:
>=20
>   git log --numstat --since "Last Year" | gitdm -n -l 10
>=20
> Reports:
>=20
>   Top changeset contributors by employer
>   Red Hat                   3126 (44.0%)
>   Linaro                    1166 (16.4%)
>   (None)                     684 (9.6%)
>   IBM                        348 (4.9%)
>   Virtuozzo                  168 (2.4%)
>   Xilinx                     102 (1.4%)
>   Wave Computing             101 (1.4%)
>   Igalia                      93 (1.3%)
>   Cadence Design Systems      88 (1.2%)
>   SiFive                      59 (0.8%)
>=20
>   Top lines changed by employer
>   Red Hat                   143166 (27.9%)
>   Cadence Design Systems    126554 (24.6%)
>   Linaro                    78845 (15.3%)
>   Wave Computing            32263 (6.3%)
>   (None)                    21789 (4.2%)
>   SiFive                    14392 (2.8%)
>   IBM                       12219 (2.4%)
>   Virtuozzo                 10445 (2.0%)
>   CodeWeavers               9179 (1.8%)
>   Xilinx                    4572 (0.9%)
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - use aliases instead of .mailmap
>   - add more companies to domainmap
>   - add more groups to cover non-corporate email
>   - add an individuals group-map for (None)
>   - limit the stats to top ten
> ---
>  contrib/gitdm/aliases               |  27 +++
>  contrib/gitdm/domain-map            |  18 ++
>  contrib/gitdm/filetypes.txt         | 362 ++++++++++++++++++++++++++++
>  contrib/gitdm/group-map-cadence     |   3 +
>  contrib/gitdm/group-map-codeweavers |   1 +
>  contrib/gitdm/group-map-ibm         |   6 +
>  contrib/gitdm/group-map-redhat      |   7 +
>  contrib/gitdm/group-map-wavecomp    |   9 +
>  gitdm.config                        |  48 ++++
>  9 files changed, 481 insertions(+)
>  create mode 100644 contrib/gitdm/aliases
>  create mode 100644 contrib/gitdm/domain-map
>  create mode 100644 contrib/gitdm/filetypes.txt
>  create mode 100644 contrib/gitdm/group-map-cadence
>  create mode 100644 contrib/gitdm/group-map-codeweavers
>  create mode 100644 contrib/gitdm/group-map-ibm
>  create mode 100644 contrib/gitdm/group-map-redhat
>  create mode 100644 contrib/gitdm/group-map-wavecomp
>  create mode 100644 gitdm.config

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
