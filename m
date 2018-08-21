Received: from eggs.gnu.org ([2001:4830:134:3::10]:57786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fs9yw-0005Y4-CL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fs9ys-0006nh-RM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:58:14 -0400
References: <cover.1534868459.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8afbce6f-a70c-6197-9be2-16f27d861fd4@redhat.com>
Date: Tue, 21 Aug 2018 12:57:55 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1534868459.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block: for jobs,
 do not clear user_paused until after the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org



On 08/21/2018 12:26 PM, Jeff Cody wrote:
> v3 changes:
>     Rebased to master
>     Patch 2: Wait for pause after mirror instead of error, to gobble th=
e
>              right message (Thanks John)
>     Patch 2: Replace a hard-coded 'qcow2' with '$IMGFMT', oops.
>=20

Thanks!

Reviewed-by: John Snow <jsnow@redhat.com>

> v2 changes:
>=20
>     Patch 1: Added r-b from John, Eric (Thanks)
>     Patch 2: Attached an iotest as patch 2
>=20
>     * cc'ed qemu-stable
>=20
> For the test in patch 2, failure here is the failure output w/o patch 1=
:
>=20
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "testdisk"}=
}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"=
}}
> -{"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "wri=
te", "action": "stop"}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk=
"}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 209715=
2, "offset": 1048576, "speed": 0, "type": "mirror"}}
> -*** done
> +QEMU_PROG: blockjob.c:460: block_job_iostatus_reset: Assertion `job->j=
ob.user_paused && job->job.pause_count > 0' failed.
> +Wrong response matching Assertion on handle 0
> Failures: 229
> Failed 1 of 1 tests
>=20
> git-backport-diff, v2->v3:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/2:[----] [--] 'block: for jobs, do not clear user_paused until afte=
r the resume'
> 002/2:[0006] [FC] 'block: iotest to catch abort on forced blockjob canc=
el'
>=20
>=20
> Jeff Cody (2):
>   block: for jobs, do not clear user_paused until after the resume
>   block: iotest to catch abort on forced blockjob cancel
>=20
>  job.c                      |  2 +-
>  tests/qemu-iotests/229     | 95 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/229.out | 23 +++++++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 120 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/229
>  create mode 100644 tests/qemu-iotests/229.out
>=20

--=20
=E2=80=94js
