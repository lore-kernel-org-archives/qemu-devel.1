Received: from eggs.gnu.org ([209.51.188.92]:48601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJHXJ-0004vI-65
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJHXF-0004S3-N8
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:02:05 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-3-thuth@redhat.com>
	<20190424112537.GF31388@redhat.com>
	<c2202c0c-e504-7678-d1f3-6afc67bd2164@redhat.com>
	<20190424125046.GJ31388@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6c4d9a8-426f-0600-0b84-5dfca4dfc0b5@redhat.com>
Date: Wed, 24 Apr 2019 15:01:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190424125046.GJ31388@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/qemu-iotests/group: Introduce a
 new "ci" group for CI pipelines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>

On 24/04/2019 14.50, Daniel P. Berrang=C3=A9 wrote:
[...]
> For automated CI, I think we should set clear desired featureset upfron=
t
> based on what we know we are supposde to have available and not silentl=
y
> skip tests

If someone really cares about running an certain iotest that depends on
an optional feature in a CI system (so far there apparently was not much
interest yet - see e.g. .travis.yml), you can also manually list the
tests that you care about in the corresponding yml file. I did so in the
.gitlab-ci.yml already for a couple of tests. Feel free to add some more
tests there after making sure that the corresponding features are
enabled in the build process before.

 Thomas
