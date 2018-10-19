Received: from eggs.gnu.org ([2001:4830:134:3::10]:57531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDQvB-0006rO-5L
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDQv6-0005JC-5q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:18:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDQv5-0005IK-S2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:18:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id r17-v6so4271460wrt.9
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 02:18:11 -0700 (PDT)
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-9-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a296b73-f080-d081-9ddb-affbd12ee775@redhat.com>
Date: Fri, 19 Oct 2018 11:18:07 +0200
MIME-Version: 1.0
In-Reply-To: <20181009130442.26296-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 08/11] authz: add QAuthZList object type
 for an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

Hi Daniel, Markus.

On 09/10/2018 15:04, Daniel P. Berrangé wrote:
...
>  .gitignore              |   4 +
>  MAINTAINERS             |   1 +
>  Makefile                |   7 +-
>  Makefile.objs           |   4 +
>  authz/Makefile.objs     |   1 +
>  authz/list.c            | 315 ++++++++++++++++++++++++++++++++++++++++
>  authz/trace-events      |   4 +
>  include/authz/list.h    | 106 ++++++++++++++
>  qapi/authz.json         |  58 ++++++++
>  qapi/qapi-schema.json   |   1 +
>  tests/Makefile.include  |   4 +
>  tests/test-authz-list.c | 171 ++++++++++++++++++++++
>  12 files changed, 675 insertions(+), 1 deletion(-)
>  create mode 100644 authz/list.c
>  create mode 100644 include/authz/list.h
>  create mode 100644 qapi/authz.json
>  create mode 100644 tests/test-authz-list.c
> 
> diff --git a/.gitignore b/.gitignore
> index 64efdfd929..9b9fcad829 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -47,6 +47,7 @@
>  /qapi/qapi-commands-trace.[ch]
>  /qapi/qapi-commands-transaction.[ch]
>  /qapi/qapi-commands-ui.[ch]
> +/qapi/qapi-commands-authz.[ch]
>  /qapi/qapi-commands.[ch]
>  /qapi/qapi-events-block-core.[ch]
>  /qapi/qapi-events-block.[ch]
> @@ -65,6 +66,7 @@
>  /qapi/qapi-events-trace.[ch]
>  /qapi/qapi-events-transaction.[ch]
>  /qapi/qapi-events-ui.[ch]
> +/qapi/qapi-events-authz.[ch]
>  /qapi/qapi-events.[ch]
>  /qapi/qapi-introspect.[ch]
>  /qapi/qapi-types-block-core.[ch]
> @@ -84,6 +86,7 @@
>  /qapi/qapi-types-trace.[ch]
>  /qapi/qapi-types-transaction.[ch]
>  /qapi/qapi-types-ui.[ch]
> +/qapi/qapi-types-authz.[ch]
>  /qapi/qapi-types.[ch]
>  /qapi/qapi-visit-block-core.[ch]
>  /qapi/qapi-visit-block.[ch]
> @@ -102,6 +105,7 @@
>  /qapi/qapi-visit-trace.[ch]
>  /qapi/qapi-visit-transaction.[ch]
>  /qapi/qapi-visit-ui.[ch]
> +/qapi/qapi-visit-authz.[ch]
>  /qapi/qapi-visit.[ch]
>  /qapi/qapi-doc.texi
>  /qemu-doc.html

We already use the '.inc.c' suffix:

$ git ls-files|fgrep  .inc.c|wc -l
38

What about starting to use the '.gen.c' one with the QAPI generated files?

That would ease the .gitignore maintenance.

Regards,

Phil.
