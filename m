Received: from eggs.gnu.org ([2001:4830:134:3::10]:33633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eld34-0004ye-Ax
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eld2z-0003yT-Rz
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:03:14 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:41093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eld2z-0003yK-Mc
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:03:09 -0500
Received: by mail-qt0-f175.google.com with SMTP id a9so4138187qtj.8
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:03:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-27-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-27-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 17:03:08 +0100
Message-ID: <CAMxuvaw6JMtbG6r60KV-ATmyTLEnxJ1eCSVLov2Lm1SKvb66Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 26/29] docs: Correct outdated
 information on QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>

On Sun, Feb 11, 2018 at 10:36 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> * Fix guidance on error classes
>
> * Point to generated documentation
>
> * Drop plea for documentation, because the QAPI code generator
>   enforces it since commit 3313b6124b
>
> * Minor tweaks here and there
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

looks good to me,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/devel/writing-qmp-commands.txt | 25 +++++++++----------------
>  docs/interop/qmp-intro.txt          |  3 ++-
>  2 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
> index 776b3b41ca..50385eff27 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -36,9 +36,9 @@ very simple and get more complex as we progress.
>  For all the examples in the next sections, the test setup is the same an=
d is
>  shown here.
>
> -First, QEMU should be started as:
> +First, QEMU should be started like this:
>
> -# /path/to/your/source/qemu [...] \
> +# qemu-system-TARGET [...] \
>      -chardev socket,id=3Dqmp,port=3D4444,host=3Dlocalhost,server \
>      -mon chardev=3Dqmp,mode=3Dcontrol,pretty=3Don
>
> @@ -179,7 +179,7 @@ described in the "Testing" section and then send two =
commands:
>      }
>  }
>
> -You should see "Hello, world" and "we love qemu" in the terminal running=
 qemu,
> +You should see "Hello, world" and "We love qemu" in the terminal running=
 qemu,
>  if you don't see these strings, then something went wrong.
>
>  =3D=3D=3D Errors =3D=3D=3D
> @@ -221,30 +221,23 @@ The QMP server's response should be:
>      }
>  }
>
> -As a general rule, all QMP errors should use ERROR_CLASS_GENERIC_ERROR
> -(done by default when using error_setg()). There are two exceptions to
> -this rule:
> +Note that error_setg() produces a "GenericError" class.  In general,
> +all QMP errors should have that error class.  There are two exceptions
> +to this rule:
>
> - 1. A non-generic ErrorClass value exists* for the failure you want to r=
eport
> -    (eg. DeviceNotFound)
> + 1. To support a management application's need to recognize a specific
> +    error for special handling
>
> - 2. Management applications have to take special action on the failure y=
ou
> -    want to report, hence you have to add a new ErrorClass value so that=
 they
> -    can check for it
> + 2. Backward compatibility
>
>  If the failure you want to report falls into one of the two cases above,
>  use error_set() with a second argument of an ErrorClass value.
>
> - * All existing ErrorClass values are defined in the qapi-schema.json fi=
le
> -
>  =3D=3D=3D Command Documentation =3D=3D=3D
>
>  There's only one step missing to make "hello-world"'s implementation com=
plete,
>  and that's its documentation in the schema file.
>
> -This is very important. No QMP command will be accepted in QEMU without =
proper
> -documentation.
> -
>  There are many examples of such documentation in the schema file already=
, but
>  here goes "hello-world"'s new entry for qapi/misc.json:
>
> diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
> index adbc94abb1..430fe1b747 100644
> --- a/docs/interop/qmp-intro.txt
> +++ b/docs/interop/qmp-intro.txt
> @@ -78,7 +78,8 @@ Escape character is '^]'.
>      }
>  }
>
> -Please, refer to the qapi-schema.json file for a complete command refere=
nce.
> +Please refer to docs/interop/qemu-qmp-ref.* for a complete command
> +reference, generated from qapi-schema.json.
>
>  QMP wiki page
>  -------------
> --
> 2.13.6
>
