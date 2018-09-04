Received: from eggs.gnu.org ([2001:4830:134:3::10]:47634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fx92f-0004Ft-N0
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fx92c-0006hf-Af
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:58:41 -0400
References: <1536044538-22507-1-git-send-email-thuth@redhat.com>
	<20180904104333.GC22349@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b2038979-044f-5a98-e130-8cbadd02489d@redhat.com>
Date: Tue, 4 Sep 2018 12:58:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180904104333.GC22349@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Save PKG_CONFIG_LIBDIR and
 WINDRES in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org

On 2018-09-04 12:43, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 04, 2018 at 09:02:18AM +0200, Thomas Huth wrote:
>> When cross-compiling QEMU for a target that significantly differs from
>> the host, the current information in config.status is not enough to
>> properly re-create the configuration. For example when I try to test
>> my build with the mingw32 cross-compiler, I regularly get this error
>> after the build system tried to re-create the configuration with the
>> config.status file:
>>
>> ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
>>        You probably need to set PKG_CONFIG_LIBDIR
>>        to point to the right pkg-config files for your
>>        build target
>>
>> A similar problem exists for the "windres" tool, where you have to
>> set the WINDRES variable in case it has a different name.
>> So let's fix these issues by storing the configuration for these
>> variables in the config.status file, too.
>=20
> Doh, I sent a patch to fix this problem more broadly years ago now:
>=20
>   https://lists.nongnu.org/archive/html/qemu-devel/2015-11/msg04157.htm=
l
>=20
> but it appears no maintainer ever merged it !

This certainly eases some configurations ... could you refresh the patch
and post it again?

 Thomas
