Received: from eggs.gnu.org ([2001:4830:134:3::10]:58789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ebsC8-0003ID-LS
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ebsC5-0006Fd-F1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:12:16 -0500
Received: from jade.ndchost.com ([204.10.36.36]:43156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shaun.reitan@ndchost.com>)
	id 1ebsC5-0005lD-8w
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:12:13 -0500
From: "Shaun Reitan" <shaun.reitan@ndchost.com>
Date: Wed, 17 Jan 2018 18:11:30 +0000
Message-Id: <em16de302b-9432-40ce-983f-88bb9dc5bba2@wkst222-laptop>
In-Reply-To: <5deda3ef-d5e4-c2a7-5556-4c46c26045ad@redhat.com>
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
	<5deda3ef-d5e4-c2a7-5556-4c46c26045ad@redhat.com>
Reply-To: "Shaun Reitan" <shaun.reitan@ndchost.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

Ok, how should i proceed with this?  I can attempt to write a=20
whitelist/blacklist check if that is what's needed.

--
Shaun Reitan
NDCHost.com

------ Original Message ------
From: "Eric Blake" <eblake@redhat.com>
To: "Shaun Reitan" <shaun.reitan@ndchost.com>; qemu-devel@nongnu.org
Cc: "Jason Wang" <jasowang@redhat.com>; "Markus Armbruster"=20
<armbru@redhat.com>
Sent: 1/17/2018 7:26:55 AM
Subject: Re: [PATCH] Add ability to provide ifname when using netdev=20
bridge or tap helper

>On 01/16/2018 05:18 PM, Shaun Reitan wrote:
>>This patch replaces the patch I sent yesturday. This one fixes
>>a bug in my original code as well as corrects a few styling
>>issues. Hopfully this one comes out correct!  Sorry for the
>>inconvienece.
>
>This paragraph belongs...
>
>>
>>When currently using -netdev bridge or -netdev tap with a helper
>>you are unable to set an ifname. This patch adds that ability so
>>that you can now specify an ifname.
>>
>>Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
>>---
>
>...here, after the --- separator.  It is useful for reviewers reading
>the list, but pointless in the git log a year from now.
>
>>  net/tap.c            | 33 ++++++++++++++++++++++++---------
>>  qapi/net.json        |  1 +
>>  qemu-bridge-helper.c | 11 +++++++++--
>>  qemu-options.hx      |  2 +-
>>  4 files changed, 35 insertions(+), 12 deletions(-)
>
>>+++ b/qapi/net.json
>>@@ -402,6 +402,7 @@
>>  { 'struct': 'NetdevBridgeOptions',
>>    'data': {
>>      '*br':     'str',
>>+    '*ifname': 'str',
>
>Missing documentation (including a '(since 2.12)' tag) of the new=20
>field.
>
>--
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3266
>Virtualization:  qemu.org | libvirt.org
>
