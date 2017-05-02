Received: from eggs.gnu.org ([2001:4830:134:3::10]:41761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5V3n-0000XD-S6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5V3i-0005pt-Vm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:29:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5V3i-0005pM-QQ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:29:30 -0400
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<20170502102105.GH3459@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <148bdb1a-2994-22ef-add3-96eb2b01d16d@redhat.com>
Date: Tue, 2 May 2017 12:29:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170502102105.GH3459@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

On 02.05.2017 12:21, Daniel P. Berrange wrote:
> On Tue, May 02, 2017 at 12:06:40PM +0200, Thomas Huth wrote:
>> The '-enable-...' option do not make too much sense: They do not
>> allow additional parameters, using '-accel xxx' is shorter than
>> '-enable-xxx' and we're also inconsistent here, since there is
>> no '-enable-xen' option available. So let's try to convince the
>> users to use '-accel xxx' instead.
>=20
> What is our general approach to deciding which of our "legacy" paramete=
rs
> are merely syntactic sugar for other parameters, vs stuff we want to
> deprecate & eventually remove ?

I'd say if the parameters can help to specify something in a short way,
then it's nice-to-have syntactic sugar. Otherwise, it's just legacy
cruft which should be removed one day.

For the accelerator options, we've got now three (!) ways to specify them=
:

1) -machine accel=3Dxxx (which is the way we use it internally, thus we
should keep it)
2) -enable-xxx
3) -accel xxx

-accel xxx makes sense as syntactic sugar since it helps to keep the
command line short, but I fail to see the reason for the inconsistent
and inflexible "-enable-xxx" here, so I'd like to suggest to mark it as
deprecated so we could remove it one day (it's likely in use in the
wild, so maybe remove it in v4.0.0 in a couple of years?).

 Thomas
