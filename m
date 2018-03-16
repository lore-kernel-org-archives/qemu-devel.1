Received: from eggs.gnu.org ([2001:4830:134:3::10]:40865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewmOd-0006jp-NB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewmOY-0006q5-6n
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:15:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewmOY-0006pG-1w
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:15:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1A887C6CC
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:15:29 +0000 (UTC)
References: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
	<20180315144719.GT3146@redhat.com>
	<20180316024023.GC13063@lemon.usersys.redhat.com>
	<20180316094351.GD3066@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a776827-ee8b-781f-1485-2fb5de01b8a2@redhat.com>
Date: Fri, 16 Mar 2018 11:15:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180316094351.GD3066@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: fedora: test more components
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 16/03/2018 10:43, Daniel P. Berrang=C3=A9 wrote:
>> I wonder if we should simply do "dnf build-dep qemu" and only list add=
itional
>> (mingw, for example) packages explicitly, like the debian dockerfiles.
> From an upstream POV it feels wrong to have our builds depend on the st=
ate
> of stuff listed in the Fedora RPM spec file, as we don't want changes i=
n
> Fedora to randomly break QEMU upstream CI.=20

I agree---I'll send v2 of this patch.

Paolo
