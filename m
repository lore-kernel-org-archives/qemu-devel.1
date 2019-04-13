Received: from eggs.gnu.org ([209.51.188.92]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFEJE-0003Tp-98
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFEJB-0002PU-E4
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:46:48 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
References: <cover.1554992449.git.berto@igalia.com>
	<6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
Date: Sat, 13 Apr 2019 10:46:26 +0200
Message-ID: <w51zhoufg2l.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Sat 13 Apr 2019 02:56:57 AM CEST, Max Reitz wrote:
>> Patch 2 fixes a different (but slightly related) issue that I found
>> while preparing the first patch.
>
> I think the real problem is that bs->backing_file is not a cache for
> bs->backing->bs->filename.
>
> In fact, every user of bs->backing_file expects it to be something
> different.  Some expect it to be a cache for
> bs->backing->bs->filename, some expect it to be what the image header
> says (i.e., it if=E2=80=99s a relative path, it=E2=80=99s relative to the=
 overlay),
> some expect it to be what the image header says, but relative paths to
> be translated so they are relative to qemu=E2=80=99s CWD.
>
> All of this should be cleaned up and this is what patch 7 in my "block:
> Deal with filters" series does:
>
> http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html

Ok, you can leave out the second patch then. The first one should still
be correct, right?

Berto
