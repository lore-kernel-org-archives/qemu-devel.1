Received: from eggs.gnu.org ([209.51.188.92]:57932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs6UY-0006rj-1y
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs6UX-0003YM-An
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gs6UR-0003Q9-95
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:46:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24F6D13363
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 13:46:36 +0000 (UTC)
References: <20181206215026.7716-1-pbonzini@redhat.com>
	<20181206215026.7716-3-pbonzini@redhat.com>
	<20190208124844.GE4494@dhcp-200-176.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9b84d67-dfb8-6dd7-dc77-9ea442bc9c5c@redhat.com>
Date: Fri, 8 Feb 2019 14:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190208124844.GE4494@dhcp-200-176.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 08/02/19 13:48, Kevin Wolf wrote:
> I just wanted to work on a unit test and found that a simple 'make
> check-tests/test-bdrv-drain' (which used to build and run the test with
> a single command) doesn't work any more.
>=20
> git bisect points to this commit.

What's wrong with "tests/test-bdrv-drain"?  (Before there were some
differences in test environment, but not now).

Paolo
