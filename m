Received: from eggs.gnu.org ([209.51.188.92]:47512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghuCz-0004cB-9Z
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghuCy-0005yd-JT
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:38:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghuCy-0005xH-BW
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:38:36 -0500
References: <1547196148-12250-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
Date: Fri, 11 Jan 2019 11:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <1547196148-12250-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] HACKING: Clarify the paragraph about
 typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 11/01/19 09:42, Thomas Huth wrote:
>  2.3. Typedefs
> -Typedefs are used to eliminate the redundant 'struct' keyword.
> +Typedefs can be used to eliminate the redundant 'struct' keyword. This=
 is
> +especially helpful for common types that are used all over the place. =
Since
> +certain C compilers choke on duplicated typedefs, you should avoid the=
m and
> +declare a typedef only in one header file. For common types, you can u=
se
> +"include/qemu/typedefs.h" for example. Note that it is also perfectly =
fine to
> +use forward struct definitions without typedefs for references in head=
ers
> +to avoid the problem with duplicated typedefs.
> =20

I agree 100% with the wording after "Since".  However, I think the first
part should be made stronger, not weaker.

Typedefs are use to eliminate the redundant 'struct' keyword, since type
names have a different style than other identifiers ("CamelCase" versus
"snake_case").  Each struct should have a CamelCase name and a
corresponding typedef.

Since certain C compilers choke on duplicated typedefs, you should avoid
them and declare a typedef only in one header file.  For common types,
you can use "include/qemu/typedefs.h" for example.  However, as a metter
of convenience it is also perfectly fine to use forward struct
definitions instead of typedefs in headers and function prototypes; this
avoids problems with duplicated typedefs and reduces the need to include
headers from other headers.

And, I would move it to CODING_STYLE since we are at it. :)

Paolo
