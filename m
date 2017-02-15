Received: from eggs.gnu.org ([2001:4830:134:3::10]:33472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce0e1-0006CK-Tc
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce0dw-00054f-WB
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:33:21 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ce0dw-00054G-NP
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:33:16 -0500
Received: by mail-wm0-x229.google.com with SMTP id c85so43386292wmi.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:33:14 -0800 (PST)
Date: Wed, 15 Feb 2017 14:24:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170215142411.GA16064@stefanha-x1.localdomain>
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
	<20170214021716.5810.4550.malone@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20170214021716.5810.4550.malone@soybean.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wayen <1662050@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2017 at 02:17:16AM -0000, wayen wrote:
> ** Attachment added: "qemu-img map new.qcow2 output"
>    https://bugs.launchpad.net/qemu/+bug/1662050/+attachment/4818564/+files/qemu_img_map_new_qcow2.txt

Thanks for posting the attachments.

I ran a script to find unallocated clusters in the delta.qcow2 host
file.  Most are actually qcow2 metadata (L1/L2 tables, refcount blocks).

This output shows that any image file size reduction you are hoping to
achieve can only come from zero clusters.

There are no holes in the files that would result in significant image
file size reduction if a new image were written out.

Just wanted to share this info in case anyone else is thinking about how
to optimize qcow2 files.  I still think rewriting images sequentially
can be useful - if internal snapshots were used and deleted then COW can
result in holes.

Hole at 0 size 5.0 clusters
Hole at 393216 size 1.0 clusters
Hole at 589824 size 1.0 clusters
Hole at 1114112 size 1.0 clusters
Hole at 1310720 size 1.0 clusters
Hole at 1507328 size 1.0 clusters
Hole at 1703936 size 1.0 clusters
Hole at 2293760 size 1.0 clusters
Hole at 2621440 size 1.0 clusters
Hole at 3080192 size 1.0 clusters
Hole at 5111808 size 1.0 clusters
Hole at 6291456 size 1.0 clusters
Hole at 30408704 size 1.0 clusters
Hole at 47906816 size 1.0 clusters
Hole at 142671872 size 1.0 clusters
Hole at 219545600 size 1.0 clusters
Hole at 667090944 size 1.0 clusters
Hole at 853868544 size 1.0 clusters
Hole at 1562640384 size 1.0 clusters
Hole at 2147483648 size 1.0 clusters
Hole at 2617180160 size 1.0 clusters
Hole at 3411148800 size 1.0 clusters
Hole at 4107075584 size 1.0 clusters
Hole at 4294967296 size 1.0 clusters
Hole at 4452646912 size 1.0 clusters
Hole at 4792057856 size 1.0 clusters
Hole at 5494865920 size 1.0 clusters
Hole at 5645271040 size 1.0 clusters
Hole at 5702483968 size 1.0 clusters
Hole at 6187188224 size 1.0 clusters
Hole at 6442450944 size 1.0 clusters
Hole at 6862995456 size 1.0 clusters
Hole at 6987317248 size 1.0 clusters
Hole at 7567245312 size 1.0 clusters
Hole at 8135245824 size 1.0 clusters
Hole at 8590589952 size 1.0 clusters
Hole at 8613462016 size 1.0 clusters
Hole at 9055436800 size 1.0 clusters
Hole at 9703522304 size 1.0 clusters
Hole at 10279321600 size 1.0 clusters
Hole at 10737418240 size 3.0 clusters
Hole at 10844372992 size 1.0 clusters
Hole at 11167858688 size 1.0 clusters
Hole at 11209605120 size 1.0 clusters
Hole at 11209801728 size 1.0 clusters
Hole at 11730944000 size 1.0 clusters
Hole at 12183207936 size 1.0 clusters
Hole at 12705464320 size 1.0 clusters
Hole at 12884901888 size 1.0 clusters
Hole at 13444120576 size 1.0 clusters
Hole at 13910016000 size 1.0 clusters
Hole at 14182711296 size 1.0 clusters
Hole at 15025635328 size 1.0 clusters
Hole at 15032385536 size 1.0 clusters

The following script draws the allocated clusters and holes in the image
file.  I took your qemu-img map output, filtered out any lines with
base.qcow2, and sorted using sort -k3 -g to sort on the "Mapped to"
field.  Then I ran ./qcow2-map-svg.py <filtered.txt >output.svg.

#!/usr/bin/python3
import sys
import io

COLOR_ALLOCATED = '#ffaaaa'
COLOR_HOLE = '#999999'

def svg_percentage(value, total):
    return '{0}%'.format(100.0 * value / total)

def svg_rect(x, width, color):
    print('<rect x="{0}" y="0" width="{1}" height="40" fill="{2}" stroke="none" />'.format(x, width, color), file=out)

def svg_text(x, y, text):
    print('<text x="{0}" y="{1}">{2}</text>'.format(x, y, text), file=out)

out = io.StringIO()

print('''<?xml version="1.0" encoding="UTF-8" ?>
<svg xmlns="http://www.w3.org/2000/svg" version="1.1">''', file=out)

file_map = []
header = True
for line in sys.stdin:
    if header:
        header = False
        continue

    offset, length, mapped, filename = line.split()
    offset = int(offset, 16)
    length = int(length, 16)
    mapped = int(mapped, 16)

    file_map.append((offset, length, mapped, filename))

file_size = file_map[-1][2] + file_map[-1][1]
last_mapped = 0
for _, length, mapped, _ in file_map:
    if mapped > last_mapped:
#        if mapped - last_mapped:
#            print('Hole at {0} size {1} clusters'.format(last_mapped, (mapped - last_mapped) / 65536))
        svg_rect(svg_percentage(last_mapped, file_size),
                 svg_percentage(mapped - last_mapped, file_size),
                 COLOR_HOLE)

    svg_rect(svg_percentage(mapped, file_size),
             svg_percentage(length, file_size),
             COLOR_ALLOCATED)
    last_mapped = mapped + length
if last_mapped < file_size:
    svg_rect(svg_percentage(last_mapped, file_size),
             svg_percentage(file_size - last_mapped, file_size),
             COLOR_HOLE)

for i in range(10):
    svg_text(svg_percentage(i, 10), 60, svg_percentage(i, 10))

print('</svg>', file=out)

print(out.getvalue())

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYpGSLAAoJEJykq7OBq3PItSkH/1uh8bVds2HPOJ8o6YHFl+ns
vDKTnz2vftaQNyWed3X//Uv4rOYfARdT5oJxN9D6yo2BoikuXdxZ1TaIF9Bo2zHS
MC6/68meIXy9BQgYo9VHCFY6pBRUXSIB5TRF6Xqgbse8S2AVbYQ1iK3krzuSqbiD
M4uHMTrSyTXgLD6MBBytQrt0mmLeoW39kYarYgI9nXVSNmiCVe+wSGb+LFnXpMiH
S12mrhZrkhpOvvpSQNYAhPclluSvRrC7MKWUlS2S84tF3lr4iv8WP9a9G9zKkvQm
PeUObu4hRPoviqkj1szFrJafU6wosJi39VpiI19tuaCfA+UHFtTPkI3MhmgFZTY=
=2jTA
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
