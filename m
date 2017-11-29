Received: from eggs.gnu.org ([2001:4830:134:3::10]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJsVu-0007Qp-46
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJsVr-0003o7-2Y
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:54:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eJsVq-0003nM-Sl
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:54:15 -0500
References: <20171129015851.16429-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7f5eac13-d29b-db32-56a5-afb799a35180@redhat.com>
Date: Tue, 28 Nov 2017 20:54:09 -0600
MIME-Version: 1.0
In-Reply-To: <20171129015851.16429-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu-web] Suggest qemu-web prefix in the
 introductory post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: yu.ning@linux.intel.com, pbonzini@redhat.com

On 11/28/2017 07:58 PM, Fam Zheng wrote:
> Chances are qemu-devel@nongnu.org patches only adding new files can be
> picked up by patchew and treated like a qemu.git patch. Patchew already
> ignores [qemu-web] patches, so suggest it in this article as well. (Are
> there better places to document this?)
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   _posts/2017-02-04-the-new-qemu-website-is-up.md | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/_posts/2017-02-04-the-new-qemu-website-is-up.md b/_posts/2017-02-04-the-new-qemu-website-is-up.md
> index 66d3181..c16053c 100644
> --- a/_posts/2017-02-04-the-new-qemu-website-is-up.md
> +++ b/_posts/2017-02-04-the-new-qemu-website-is-up.md
> @@ -19,7 +19,8 @@ and the source code for the website can be cloned from the
>   repository.  Just like for any other project hosted by QEMU, the best way
>   to propose or contribute a new change is by sending a patch through the
>   [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)
> -mailing list.
> +mailing list. (Add `[qemu-web PATCH]` to the subject so that CI will not be
> +confused with qemu.git patches.)
>   

I suggest mentioning that "git config format.subjectprefix 'qemu-web 
PATCH"' will automate that process, so you don't have to think about it 
when doing git send-email.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
