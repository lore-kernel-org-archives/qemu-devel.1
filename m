Received: from eggs.gnu.org ([2001:4830:134:3::10]:41514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKaN-0006YS-EQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKaJ-0005mj-GT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:19:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ebKaJ-0005mJ-Af
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:18:59 -0500
References: <1515700960-26388-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f8e0bee0-e7cd-340b-e5fa-fe2c6c80d264@redhat.com>
Date: Tue, 16 Jan 2018 14:18:50 +0800
MIME-Version: 1.0
In-Reply-To: <1515700960-26388-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Allow netdevs to be used with
 'hostfwd_add' and 'hostfwd_remove'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 04:02, Thomas Huth wrote:
> It does not make much sense to limit these commands to the legacy 'vlan=
'
> concept only, they should work with the modern netdevs, too. So now
> it is possible to use this command with one, two or three parameters.
>
> With one parameter, the command installs a hostfwd rule on the default
> "user" network:
>      hostfwd_add tcp:...
>
> With two parameters, the command installs a hostfwd rule on a netdev
> (that's the new way of using this command):
>      hostfwd_add netdev_id tcp:...
>
> With three parameters, the command installs a rule on a 'vlan' (aka hub=
):
>      hostfwd_add hub_id name tcp:...
>
> Same applies to the hostfwd_remove command now.
>
> Signed-off-by: Thomas Huth<thuth@redhat.com>

Applied.

Thanks
