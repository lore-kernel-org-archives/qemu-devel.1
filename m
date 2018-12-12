Received: from eggs.gnu.org ([2001:4830:134:3::10]:42242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gX7Cs-0004N4-Sy
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gX7Co-0003ZZ-Md
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:17:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gX7Co-0003Yq-Ef
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:17:50 -0500
References: <1544606032-16924-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd3cff86-21a1-9223-5d95-4381e3d06b63@redhat.com>
Date: Wed, 12 Dec 2018 10:17:47 -0600
MIME-Version: 1.0
In-Reply-To: <1544606032-16924-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] Set minimum compiler versions to GCC
 4.8 and Clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 12/12/18 3:13 AM, Thomas Huth wrote:
>   Hi Peter,
> 
> the following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
> 
>    Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
> 
> are available in the git repository at:
> 
>    https://gitlab.com/huth/qemu.git tags/pull-request-2018-12-12
> 
> for you to fetch changes up to 2b4c1125ac3db2734222ff43c25388a16aca4a99:
> 
>    i2c: Move typedef of bitbang_i2c_interface to i2c.h (2018-12-12 10:01:13 +0100)
> 
> ----------------------------------------------------------------
> Explicitly check for minimum compiler versions.
> Remove obsolete code for old compilers that is now not required anymore.
> Fix a duplicated typedef for Clang 3.4.

Paolo's pending request includes some of the same patches. Git will 
probably do the right thing even if a patch is introduced twice through 
two arms of a merge, but I'm flagging it just in case either maintainer 
wants to coordinate sending a v2 pull request in time for Peter to not 
have to worry about the duplication.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
