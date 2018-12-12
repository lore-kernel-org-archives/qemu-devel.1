Received: from eggs.gnu.org ([2001:4830:134:3::10]:42332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX8Z7-0000LS-P1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX8Z5-000727-Ey
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:44:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX8Z4-00071U-Vn
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:44:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181212102548.27626-1-alex.bennee@linaro.org>
Date: Wed, 12 Dec 2018 18:44:51 +0100
In-Reply-To: <20181212102548.27626-1-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Wed, 12 Dec 2018 10:25:48 +0000")
Message-ID: <87mupafxm4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This is a QEMU specific version of a gitdm config for generating
> reports on the contributor base of the project. I've added enough
> group maps and domain aliases to ensure the current top ten is as
> reflective as it can be. As of this commit running:
>
>   git log --numstat --since "Last Year" | gitdm -n -l 10
>
> Reports:
>
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
>
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
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
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
>
> diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
> new file mode 100644
> index 0000000000..07fd3391a5
> --- /dev/null
> +++ b/contrib/gitdm/aliases
> @@ -0,0 +1,27 @@
> +#
> +# This is the email aliases file, mapping secondary addresses
> +# onto a single, canonical address. Duplicates some info from .mailmap
> +#
> +
> +# weird commits
> +balrog@c046a42c-6fe2-441c-8c8c-71466251a162 balrogg@gmail.com
> +aliguori@c046a42c-6fe2-441c-8c8c-71466251a162 anthony@codemonkey.ws
> +aurel32@c046a42c-6fe2-441c-8c8c-71466251a162 aurelien@aurel32.net
> +blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162 blauwirbel@gmail.com
> +edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162 edgar.iglesias@gmail.com
> +bellard@c046a42c-6fe2-441c-8c8c-71466251a162 fabrice@bellard.org
> +j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162 l_indien@magic.fr
> +pbrook@c046a42c-6fe2-441c-8c8c-71466251a162 paul@codesourcery.com
> +ths@c046a42c-6fe2-441c-8c8c-71466251a162 ths@networkno.de
> +malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru
> +
> +# There is also a:
> +#    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
> +# for the cvs2svn initialization commit e63c3dc74bf.
> +
> +# Next, translate a few commits where mailman rewrote the From: line due
> +# to strict SPF, although we prefer to avoid adding more entries like th=
at.
> +"Ed Swierk via Qemu-devel" eswierk@skyportsystems.com
> +"Ian McKellar via Qemu-devel" ianloic@google.com
> +"Julia Suvorova via Qemu-devel" jusual@mail.ru
> +"Justin Terry (VM) via Qemu-devel" juterry@microsoft.com
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> new file mode 100644
> index 0000000000..7caf7c6332
> --- /dev/null
> +++ b/contrib/gitdm/domain-map
> @@ -0,0 +1,18 @@
> +#
> +# QEMU gitdm domain-map
> +#
> +# This maps email domains to nice easy to read company names
> +#
> +
> +amd.com         AMD
> +ibm.com         IBM
> +igalia.com      Igalia
> +ispras.ru       Institute for System Programming of RAS
> +linaro.org      Linaro
> +oracle.com      Oracle
> +redhat.com      Red Hat
> +siemens.com     Siemens
> +sifive.com      SiFive
> +suse.de         SUSE
> +virtuozzo.com   Virtuozzo
> +xilinx.com      Xilinx
> diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
> new file mode 100644
> index 0000000000..e24c396b48
> --- /dev/null
> +++ b/contrib/gitdm/filetypes.txt
[...]

This is a verbatim copy of upstream's sample-config/filetypes.txt.  If
you have gitdm, you should have its filetypes.txt, shouldn't you?  Can
we think of a way to use that instead?

> diff --git a/contrib/gitdm/group-map-cadence b/contrib/gitdm/group-map-ca=
dence
> new file mode 100644
> index 0000000000..ab97dd2fc3
> --- /dev/null
> +++ b/contrib/gitdm/group-map-cadence
> @@ -0,0 +1,3 @@
> +# Cadence Design Systems
> +
> +jcmvbkbc@gmail.com
> diff --git a/contrib/gitdm/group-map-codeweavers b/contrib/gitdm/group-ma=
p-codeweavers
> new file mode 100644
> index 0000000000..c4803489e2
> --- /dev/null
> +++ b/contrib/gitdm/group-map-codeweavers
> @@ -0,0 +1 @@
> +sergio.g.delreal@gmail.com
> diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
> new file mode 100644
> index 0000000000..b66db5f4a8
> --- /dev/null
> +++ b/contrib/gitdm/group-map-ibm
> @@ -0,0 +1,6 @@
> +#
> +# Some IBM contributors submit via another domain
> +#
> +
> +clg@kaod.org
> +groug@kaod.org
> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-red=
hat
> new file mode 100644
> index 0000000000..252742d131
> --- /dev/null
> +++ b/contrib/gitdm/group-map-redhat
> @@ -0,0 +1,7 @@
> +#
> +# RedHat contributors using non-corporate email
> +#
> +
> +david@gibson.dropbear.id.au
> +laurent@vivier.eu
> +pjp@fedoraproject.org

There are about a dozen commits I accidentally signed with my private
address armbru@pond.sub.org.  Not sure we care.

> diff --git a/contrib/gitdm/group-map-wavecomp b/contrib/gitdm/group-map-w=
avecomp
> new file mode 100644
> index 0000000000..772856bca8
> --- /dev/null
> +++ b/contrib/gitdm/group-map-wavecomp
> @@ -0,0 +1,9 @@
> +#
> +# Wave Computing acquired MIPS in June 2018 from imgtec
> +#
> +
> +amarkovic@wavecomp.com
> +smarkovic@wavecomp.com
> +paul.burton@imgtec.com
> +yongbok.kim@imgtec.com
> +yongbok.kim@mips.com
> diff --git a/gitdm.config b/gitdm.config
> new file mode 100644
> index 0000000000..69e5223d90
> --- /dev/null
> +++ b/gitdm.config
> @@ -0,0 +1,48 @@
> +#
> +# This is the gitdm configuration file for QEMU.
> +#
> +# It is to be used with LWN's git dataminer tool for generating
> +# reports about development activity in the QEMU repo. The LWN gitdm
> +# tool can be found at:
> +#
> +#   git://git.lwn.net/gitdm.git
> +#
> +# A run to generate a report for the last year of activity would be
> +#
> +#     $ git-log --numstat -M v2.12.0..v3.0.0 | gitdm -n -l 16
> +#
> +
> +# EmailAliases lets us cope with developers who use more
> +# than one address or have changed addresses. This duplicates some of
> +# the information in the existing .mailmap but in a slightly different
> +# form.
> +#
> +EmailAliases contrib/gitdm/aliases
> +
> +#
> +# EmailMap does the main work of mapping addresses onto
> +# employers.
> +#
> +EmailMap contrib/gitdm/domain-map
> +
> +#
> +# Use GroupMap to map a file full of addresses to the
> +# same employer. This is used for people that don't post from easily
> +# identifiable corportate emails.
> +#
> +
> +GroupMap contrib/gitdm/group-map-redhat Red Hat
> +GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
> +GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
> +GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
> +GroupMap contrib/gitdm/group-map-ibm IBM
> +
> +# Also group together our prolific individual contributors
> +GroupMap contrib/gitdm/group-map-individuals (None)
> +
> +#
> +#
> +# Use FileTypeMap to map a file types to file names using regular
> +# regular expressions.
> +#
> +FileTypeMap contrib/gitdm/filetypes.txt

Can't see anything bad, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>
