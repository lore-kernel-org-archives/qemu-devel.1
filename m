Received: from eggs.gnu.org ([2001:4830:134:3::10]:39843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyjyZ-0006Cm-Mz
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyjyW-0005A2-J7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:04:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyjyW-00059g-Dm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:04:44 -0400
Date: Wed, 21 Mar 2018 20:04:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180321200440.GA3466@work-vm>
References: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5.2 for 2.13 0/4] tpm: Extend TPM with
 state migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

* Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> This series of patches implements support for migrating the state of th=
e
> external 'swtpm' TPM emulator as well as that of the TIS interface.=20
>=20
> For testing of TPM 2 (migration) please use the following git repos and
> branches:
>=20
> libtpms:=20
>    - repo: https://github.com/stefanberger/libtpms
>    - branch: tpm2-preview.rev146.v2
>=20
> swtpm:
>    - repo: https://github.com/stefanberger/swtpm
>    - branch: tpm2-preview.rev146.v2

I don't see that branch in the swtpm tree:
[dgilbert@dgilbert-t530 swtpm]$ git branch -a
* (HEAD detached at origin/master)
  master
  remotes/origin/HEAD -> origin/master
  remotes/origin/coverity_scan
  remotes/origin/master
  remotes/origin/master.next
  remotes/origin/tpm2-preview
  remotes/origin/tpm2-preview.v2

(I need to untangle my system libtpms from that specific version to get i=
t to build as
well)

Dave

> Regards,
>   Stefan
>=20
> Changes:
>  v4->v5:
>    - followed Marc-Andr=E9's and Alan's comments where possible; some c=
omments
>      were not addressed and reasons posted to mailing list
>    - converted debug statements to tracing
>    - qemu_chr_fe_read_all does not return errno, so displaying expected=
 versus
>      received number of bytes rather than strerror(errno)
>    - added test cases
>    - added documentation for migration to docs/spec/tpm.txt
>=20
>  v3->v4:
>    - dropped the size limit enforcement on blobs received from the swtp=
m
>    - the .post_load migration function requires errno's to be returned.
>      -> some of the functions have been converted to return a better er=
rno
>=20
>=20
> Stefan Berger (4):
>   tpm: extend TPM emulator with state migration support
>   tpm: extend TPM TIS with state migration support
>   docs: tpm: add VM save/restore example and troubleshooting guide
>   tpm: Add test cases that uses the external swtpm with CRB interface
>=20
>  docs/specs/tpm.txt         | 106 +++++++++++++++
>  hw/tpm/tpm_emulator.c      | 318 +++++++++++++++++++++++++++++++++++++=
++++++--
>  hw/tpm/tpm_tis.c           |  52 +++++++-
>  hw/tpm/trace-events        |   9 +-
>  tests/Makefile.include     |   3 +
>  tests/tpm-crb-swtpm-test.c | 244 ++++++++++++++++++++++++++++++++++
>  tests/tpm-util.c           | 143 ++++++++++++++++++++
>  tests/tpm-util.h           |  36 +++++
>  8 files changed, 897 insertions(+), 14 deletions(-)
>  create mode 100644 tests/tpm-crb-swtpm-test.c
>  create mode 100644 tests/tpm-util.c
>  create mode 100644 tests/tpm-util.h
>=20
> --=20
> 2.5.5
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
