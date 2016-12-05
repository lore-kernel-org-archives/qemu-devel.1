Received: from eggs.gnu.org ([2001:4830:134:3::10]:49469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwXv-0007Bb-7N
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwXs-0002TS-5H
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:55:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwXr-0002TE-Up
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:55:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1479922617-4400-1-git-send-email-eblake@redhat.com>
Date: Mon, 05 Dec 2016 17:55:12 +0100
In-Reply-To: <1479922617-4400-1-git-send-email-eblake@redhat.com> (Eric
	Blake's message of "Wed, 23 Nov 2016 11:36:53 -0600")
Message-ID: <877f7euxhr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 for-2.8 0/4] Fix MacOS runtime failure
 of qobject_from_jsonf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, programmingkidx@gmail.com, pbonzini@redhat.com

Eric Blake <eblake@redhat.com> writes:

> programmingkidx@gmail.com[*] reported a runtime failure on a
> 32-bit Mac OS compilation, where "%"PRId64 expands to "%qd".
> Fortunately, we had very few spots that were relying on our
> pseudo-printf JSON parsing of int64_t numbers, so it was
> easier to just convert callers to stick to safer %lld.
>
> The remaining uses of pseudo-printf handling are more complex;
> there are only 3 users in the released codebased, but LOTS of
> users in the testsuite (via wrapper functions like qmp()); I
> will be posting a followup series that rips out the remaining
> uses of dynamic JSON, but it will be 2.9 material, while
> these (first three) patches qualify for 2.8.  The fourth patch
> is RFC; not intended to be applied now, but shows how I tested
> patch 3/4; it will probably reappear in the later 2.9 series.
>
> [*] git log shows the name John, but the particular email that
> sparked this only stated the non-descript name 'G 3', which
> makes it a bit hard for me to know which form is preferred
> when lending credit.

PATCH 1-3 applied to qapi-next for 2.8 with minor touch-ups.  Thanks!
