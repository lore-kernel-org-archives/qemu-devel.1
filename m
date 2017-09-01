Received: from eggs.gnu.org ([2001:4830:134:3::10]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlIi-0003Fo-26
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlId-000299-DN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlId-00028z-7j
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:43:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Date: Fri, 01 Sep 2017 14:43:45 +0200
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Thu, 24 Aug 2017 10:45:55 +0200")
Message-ID: <87d17a6132.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/16] qapi: Rework mapping of enum value
 to string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Markus Armbruster <armbru@redhat.com> writes:

> The purpose of this work is to make holes in QAPI enumerations
> possible.
>
> Why holes?  Because we want to be able to suppress enumeration
> constants with #if.  Holes could be avoided, e.g. by letting the
> compiler assign the values.  Falls apart when the conditions are
> target-specific, because then target-specific code would get different
> values.
>
> Why are holes a problem?  The tables mapping enumeration constants to
> strings use a NULL sentinel.
>
> This is PATCH 06-13 of "[PATCH v2 00/54] qapi: add #if pre-processor
> conditions to generated code" reworked for reviewability.  Took a bit
> of time, but it was probably less work and certainly more fun than
> reviewing the old PATCH 06 and 12 (almost 300 hunks!) in sufficient
> depth would have been.

Applied to qapi-next.
