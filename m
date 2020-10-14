Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DCFC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C778021D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ai/5WJOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C778021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlRs-00031J-J0
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kSlQU-0002Vj-EB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:23:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:45556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kSlQR-0002Jk-K0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1602699775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eShCWvHdQ09zUGfpJH6fzbxPj+P1bueWtZRZ0NKV0Y=;
 b=Ai/5WJOUNDWpi+vsA/Ade9hxOhvKWHlMWBreir+/juDnCRoRe5ac5t4i1soCjJy25zDRHV
 x0ovRn0BqCyAiPZ5mfL6EN+ypI7XB4i4rlKfI2+gBgbg7zuSA8CH+4ENGIHAmZONSdMJHJ
 9SqbqRppofvNKYwE+aH+mujwgDwbQRc=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-msuZP7BfO76bA6PHZf7xXA-1; Wed, 14 Oct 2020 20:22:54 +0200
X-MC-Unique: msuZP7BfO76bA6PHZf7xXA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH7pi2ynPuW21qVJxpJbJ8aoYhZsY+8Ek4zfRMPHsWUzGNO+Z8zz8evbHCOvXulgWZJ8cq8Frv4DwKDznHvc2g09G+EzpjCTtTOP2dlPvFURGsyZ9jmQM4yW2ZepxUilHHmupimbgnRoVjLVEuy09ftyeAq13UOShSVGS+AqpV/IeVud9rNMaXDORq6k+uBd2EtxeQy4qJEFOxpp3z9lh/TihWhForaHCfAv56+owpnmAwpePwJxdJG2dG5J116IhtDkh1YCyQTDJHYLmmBE6FEZI0Libt+PlJWiiHxRpPF0JrCkA3EZ0znqQqPeTau+D7xJc8/o1E8eUsGL4AcIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eShCWvHdQ09zUGfpJH6fzbxPj+P1bueWtZRZ0NKV0Y=;
 b=T153tFH7zRDBn94UYfz9pCKOM/GYmdkITK1JqlLoLSmkXOb5Jb7q8c1iOs06DYCH5d7sUUvujklNq1yU+5KhRd9cggrIMgQYyOMu2qY51J4Lhnvjlwt1l7AI00HxVQMiU7nyUbd11VJsKY60HdMo6A1iduDPbMT/Wla53JGZ8AF77uVGN39lTYJ2GeTjD6E4lm4LQYUSl0RakWHDWcrY6/CBMv7LVGMgdq8tWy3eo6O9DErI2jqFTZCi2qecED3dY2prrXquH71ZIlJg9KpujH/lwxVmqkrbENIzzkU5MJ0az5atvKhBGJ+ZO5FRpzmeqXLwaUsPoj7cNLnR3c/Qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR0402MB3443.eurprd04.prod.outlook.com
 (2603:10a6:208:1b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 18:22:53 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 18:22:53 +0000
Message-ID: <391ba08ce827326c2706b0ebfd2801360d0b7512.camel@suse.com>
Subject: Re: [PULL 5/9] configure: Fixes ncursesw detection under
 msys2/mingw by convert them to meson
From: Bruce Rogers <brogers@suse.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 14 Oct 2020 12:22:46 -0600
In-Reply-To: <20201014082149.26853-6-kraxel@redhat.com>
References: <20201014082149.26853-1-kraxel@redhat.com>
 <20201014082149.26853-6-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [63.248.145.198]
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (63.248.145.198) by
 AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Wed, 14 Oct 2020 18:22:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650797ec-039b-4e34-25d6-08d8706e29f1
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3443:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3443777187DDB0CAB2EECB73D9050@AM0PR0402MB3443.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGkskJDmWb42QwL/5moC41fPzorpLiHfY7L8ER/es8DQBWRBD+6Y8AFHj9AQmWavUpzlCDH8sEvEJjt8zd1sWT6VSH0teCRsAD1KrSRNutylQTohvjJFNP1bi9flpRpbOFHWWN8gzAW3Kfzjy5Tj3H60WwpZY7EPjtHLHexIswtZn+SBGyiVp1/ps60cUPUp/83/9m8lNIMIE54UWask9i1RQ+UQtNXQGOG6UOQHTHB41xCkPynt6vNruR7CobNTTbOzWKDJco6tMzG8GLHk4s0nZ8BVAna29D/HgtKPiKwp+az6XjiimBlGp3/PDi/p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(376002)(39850400004)(136003)(366004)(30864003)(83380400001)(4326008)(6666004)(66946007)(8936002)(6486002)(66476007)(8676002)(66556008)(5660300002)(54906003)(86362001)(186003)(16526019)(16576012)(956004)(36756003)(316002)(26005)(52116002)(478600001)(2616005)(4001150100001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jhu0PgR9epxQkfmK/eueqeDs04NtTZQRgl/mIsm1gfdgSW4Y4nXVEA35La/60eywBO8HjxWWYz8Alf/PttA75k0pB4zRQHRj67MQuyD1K+n0jqRlSPlF+JJg3T7wj/1fKPtnNkONU+K65hNdvdzf+abufRweEIkmXwenjNhWL0gVb15BXB7mTT86Mg71vKxJzcv6Q7b7MW2CunczESuLQyxPWLoK75stffq++fJLXz1d8Cr6n+egF/1szhBc2z/HbvhVc33qenk7j9lBWAkOKks7PVCWilqhng4q74iggGQZUhd385t6c6XeT90piZeBXiGZxRkypeoLH+Eo3ER1WjLZ3YzW6J1Wnsv4tZrOEmj4s6Uu2OS8So6RogG2NFezqz6s346Dzb/ji9J+5Caglj9oNXb47AFS4ZgABq2tScQP8hqNB+deX1oxyy6aQz5mp/o2Rh2lmxzh3uvVSTKGGVrbSOcuEjkujzMJoKRHCjox2FvpoEn6Qfa52TYKEvJ5Hvn0Giak1JLH7HY8f4f37k/+IKi2IlCE9QnTzahtxUY6rl0+/kNbHcqKxfT7ll+EIz0F9aMdZaesFyVc+GxhUCczGKHeXAm51lWe2MhN49VJXgFHuLwAA+OJExTW0E+NAPmRuv6iU3SuJ7pIehPSQw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650797ec-039b-4e34-25d6-08d8706e29f1
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 18:22:53.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZWNo53QqJsbAB7jCSlqrB+9+JpH0a206TXvbk9jeG7m5fmv2PGQQaHpw1L4CFFcwgMJMeEcMnwCu7qGo1iUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3443
Received-SPF: pass client-ip=62.140.7.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 14:22:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-10-14 at 10:21 +0200, Gerd Hoffmann wrote:
> From: Yonggang Luo <luoyonggang@gmail.com>
> 
> The mingw pkg-config are showing following absolute path and contains
> : as the separator,
> 
> -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC:/CI-
> Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC
> -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC
> -lncursesw
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC
> -lcursesw
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe
> -lncursesw -lgnurx -ltre -lintl -liconv
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw
> -lncursesw
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw
> -lcursesw
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx
> -ltre -lintl -liconv
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-id: 20201012234348.1427-6-luoyonggang@gmail.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure         | 118 +++-----------------------------------------
> --
>  meson_options.txt |   4 ++
>  meson.build       |  83 +++++++++++++++++++++++++++-----
>  ui/meson.build    |   2 +-
>  4 files changed, 83 insertions(+), 124 deletions(-)
> 
> diff --git a/configure b/configure
> index 9a87685517ee..f839c2a557c3 100755
> --- a/configure
> +++ b/configure
> @@ -295,7 +295,8 @@ unset target_list_exclude
>  
>  brlapi=""
>  curl=""
> -curses=""
> +iconv="auto"
> +curses="auto"
>  docs=""
>  fdt="auto"
>  netmap="no"
> @@ -1173,13 +1174,13 @@ for opt do
>    ;;
>    --disable-safe-stack) safe_stack="no"
>    ;;
> -  --disable-curses) curses="no"
> +  --disable-curses) curses="disabled"
>    ;;
> -  --enable-curses) curses="yes"
> +  --enable-curses) curses="enabled"
>    ;;
> -  --disable-iconv) iconv="no"
> +  --disable-iconv) iconv="disabled"
>    ;;
> -  --enable-iconv) iconv="yes"
> +  --enable-iconv) iconv="enabled"
>    ;;
>    --disable-curl) curl="no"
>    ;;
> @@ -3440,102 +3441,6 @@ EOF
>    fi
>  fi
>  
> -##########################################
> -# iconv probe
> -if test "$iconv" != "no" ; then
> -  cat > $TMPC << EOF
> -#include <iconv.h>
> -int main(void) {
> -  iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
> -  return conv != (iconv_t) -1;
> -}
> -EOF
> -  iconv_prefix_list="/usr/local:/usr"
> -  iconv_lib_list=":-liconv"
> -  IFS=:
> -  for iconv_prefix in $iconv_prefix_list; do
> -    IFS=:
> -    iconv_cflags="-I$iconv_prefix/include"
> -    iconv_ldflags="-L$iconv_prefix/lib"
> -    for iconv_link in $iconv_lib_list; do
> -      unset IFS
> -      iconv_lib="$iconv_ldflags $iconv_link"
> -      echo "looking at iconv in '$iconv_cflags' '$iconv_lib'" >>
> config.log
> -      if compile_prog "$iconv_cflags" "$iconv_lib" ; then
> -        iconv_found=yes
> -        break
> -      fi
> -    done
> -    if test "$iconv_found" = yes ; then
> -      break
> -    fi
> -  done
> -  if test "$iconv_found" = "yes" ; then
> -    iconv=yes
> -  else
> -    if test "$iconv" = "yes" ; then
> -      feature_not_found "iconv" "Install iconv devel"
> -    fi
> -    iconv=no
> -  fi
> -fi
> -
> -##########################################
> -# curses probe
> -if test "$iconv" = "no" ; then
> -  # curses will need iconv
> -  curses=no
> -fi
> -if test "$curses" != "no" ; then
> -  if test "$mingw32" = "yes" ; then
> -    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
> -    curses_lib_list="$($pkg_config --libs ncurses 2>/dev/null):-
> lpdcurses"
> -  else
> -    curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-
> I/usr/include/ncursesw:"
> -    curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-
> lncursesw:-lcursesw"
> -  fi
> -  curses_found=no
> -  cat > $TMPC << EOF
> -#include <locale.h>
> -#include <curses.h>
> -#include <wchar.h>
> -int main(void) {
> -  wchar_t wch = L'w';
> -  setlocale(LC_ALL, "");
> -  resize_term(0, 0);
> -  addwstr(L"wide chars\n");
> -  addnwstr(&wch, 1);
> -  add_wch(WACS_DEGREE);
> -  return 0;
> -}
> -EOF
> -  IFS=:
> -  for curses_inc in $curses_inc_list; do
> -    # Make sure we get the wide character prototypes
> -    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
> -    IFS=:
> -    for curses_lib in $curses_lib_list; do
> -      unset IFS
> -      if compile_prog "$curses_inc" "$curses_lib" ; then
> -        curses_found=yes
> -        break
> -      fi
> -    done
> -    if test "$curses_found" = yes ; then
> -      break
> -    fi
> -  done
> -  unset IFS
> -  if test "$curses_found" = "yes" ; then
> -    curses=yes
> -  else
> -    if test "$curses" = "yes" ; then
> -      feature_not_found "curses" "Install ncurses devel"
> -    fi
> -    curses=no
> -  fi
> -fi
> -
>  ##########################################
>  # curl probe
>  if test "$curl" != "no" ; then
> @@ -6200,16 +6105,6 @@ if test "$have_x11" = "yes" && test
> "$need_x11" = "yes"; then
>    echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
>    echo "X11_LIBS=$x11_libs" >> $config_host_mak
>  fi
> -if test "$iconv" = "yes" ; then
> -  echo "CONFIG_ICONV=y" >> $config_host_mak
> -  echo "ICONV_CFLAGS=$iconv_cflags" >> $config_host_mak
> -  echo "ICONV_LIBS=$iconv_lib" >> $config_host_mak
> -fi
> -if test "$curses" = "yes" ; then
> -  echo "CONFIG_CURSES=y" >> $config_host_mak
> -  echo "CURSES_CFLAGS=$curses_inc" >> $config_host_mak
> -  echo "CURSES_LIBS=$curses_lib" >> $config_host_mak
> -fi
>  if test "$pipe2" = "yes" ; then
>    echo "CONFIG_PIPE2=y" >> $config_host_mak
>  fi
> @@ -7181,6 +7076,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>          -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg
> -Dvnc_png=$vnc_png \
>          -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
>          -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
> +        -Diconv=$iconv -Dcurses=$curses \
>          $cross_arg \
>          "$PWD" "$source_path"
>  
> diff --git a/meson_options.txt b/meson_options.txt
> index 1d3c94840a90..e6cb1e589b4e 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -32,6 +32,10 @@ option('cocoa', type : 'feature', value : 'auto',
>         description: 'Cocoa user interface (macOS only)')
>  option('mpath', type : 'feature', value : 'auto',
>         description: 'Multipath persistent reservation passthrough')
> +option('iconv', type : 'feature', value : 'auto',
> +       description: 'Font glyph conversion support')
> +option('curses', type : 'feature', value : 'auto',
> +       description: 'curses UI')
>  option('sdl', type : 'feature', value : 'auto',
>         description: 'SDL user interface')
>  option('sdl_image', type : 'feature', value : 'auto',
> diff --git a/meson.build b/meson.build
> index ad6c7c90c787..1a4a48249243 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -426,6 +426,74 @@ if targetos == 'linux' and have_tools and not
> get_option('mpath').disabled()
>    endif
>  endif
>  
> +iconv = not_found
> +if not get_option('iconv').disabled()
> +  libiconv = cc.find_library('iconv',
> +                             required: false,
> +                             static: enable_static)
> +  if libiconv.found()
> +    if cc.links('''
> +      #include <iconv.h>
> +      int main(void) {
> +        iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
> +        return conv != (iconv_t) -1;
> +      }''', dependencies: [libiconv])
> +      iconv = declare_dependency(dependencies: [libiconv])
> +    endif
> +  endif
> +endif
> +if get_option('iconv').enabled() and not iconv.found()
> +  error('Cannot detect iconv API')
> +endif
> +
> +curses = not_found
> +if iconv.found() and not get_option('curses').disabled()
> +  curses_libname_list = ['ncursesw', 'ncurses', 'cursesw',
> 'pdcurses']
> +  curses_test = '''
> +    #include <locale.h>
> +    #include <curses.h>
> +    #include <wchar.h>
> +    int main(void) {
> +      wchar_t wch = L'w';
> +      setlocale(LC_ALL, "");
> +      resize_term(0, 0);
> +      addwstr(L"wide chars\n");
> +      addnwstr(&wch, 1);
> +      add_wch(WACS_DEGREE);
> +      return 0;
> +    }'''
> +  foreach curses_libname : curses_libname_list
> +      libcurses = dependency(curses_libname,
> +                             required: false,
> +                             method: 'pkg-config',
> +                             static: enable_static)
> +
> +      if not libcurses.found()
> +        dirs = ['/usr/include/ncursesw']
> +        if targetos == 'windows'
> +          dirs = []
> +        endif
> +        libcurses = cc.find_library(curses_libname,
> +                                    required: false,
> +                                    dirs: dirs,
> +                                    static: enable_static)
> +      endif
> +      if libcurses.found()
> +        if cc.links(curses_test, dependencies: [libcurses])
> +          curses = declare_dependency(compile_args: '-
> DNCURSES_WIDECHAR', dependencies: [libcurses])
> +          break
> +        endif
> +      endif
> +  endforeach
> +endif
> +if get_option('curses').enabled() and not curses.found()
> +  if not iconv.found()
> +    error('Cannot detect iconv API')
> +  else
> +    error('Cannot detect curses API')
> +  endif
> +endif
> +
>  brlapi = not_found
>  if 'CONFIG_BRLAPI' in config_host
>    brlapi = declare_dependency(link_args:
> config_host['BRLAPI_LIBS'].split())
> @@ -504,16 +572,6 @@ if 'CONFIG_X11' in config_host
>    x11 = declare_dependency(compile_args:
> config_host['X11_CFLAGS'].split(),
>                             link_args:
> config_host['X11_LIBS'].split())
>  endif
> -curses = not_found
> -if 'CONFIG_CURSES' in config_host
> -  curses = declare_dependency(compile_args:
> config_host['CURSES_CFLAGS'].split(),
> -                              link_args:
> config_host['CURSES_LIBS'].split())
> -endif
> -iconv = not_found
> -if 'CONFIG_ICONV' in config_host
> -  iconv = declare_dependency(compile_args:
> config_host['ICONV_CFLAGS'].split(),
> -                             link_args:
> config_host['ICONV_LIBS'].split())
> -endif
>  vnc = not_found
>  png = not_found
>  jpeg = not_found
> @@ -622,6 +680,7 @@ config_host_data.set('CONFIG_COCOA',
> cocoa.found())
>  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
>  config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
> +config_host_data.set('CONFIG_CURSES', curses.found())
>  config_host_data.set('CONFIG_SDL', sdl.found())
>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
>  config_host_data.set('CONFIG_VNC', vnc.found())
> @@ -1905,8 +1964,8 @@ if config_host.has_key('CONFIG_NETTLE')
>  endif
>  summary_info +=
> {'libtasn1':          config_host.has_key('CONFIG_TASN1')}
>  summary_info +=
> {'PAM':               config_host.has_key('CONFIG_AUTH_PAM')}
> -summary_info += {'iconv
> support':     config_host.has_key('CONFIG_ICONV')}
> -summary_info += {'curses
> support':    config_host.has_key('CONFIG_CURSES')}
> +summary_info += {'iconv support':     iconv.found()}
> +summary_info += {'curses support':    curses.found()}
>  # TODO: add back version
>  summary_info += {'virgl
> support':     config_host.has_key('CONFIG_VIRGL')}
>  summary_info += {'curl
> support':      config_host.has_key('CONFIG_CURL')}
> diff --git a/ui/meson.build b/ui/meson.build
> index 8a080c38e325..78ad792ffb8d 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -39,7 +39,7 @@ specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true:
> opengl)
>  
>  ui_modules = {}
>  
> -if config_host.has_key('CONFIG_CURSES')
> +if curses.found()
>    curses_ss = ss.source_set()
>    curses_ss.add(when: [curses, iconv], if_true: [files('curses.c'),
> pixman])
>    ui_modules += {'curses' : curses_ss}

I find that this change causes a configure failure when choosing either
--enable-iconv or --enable-curses as follows:

../configure --enable-curses results in 
../meson.build:491:4: ERROR: Problem encountered: Cannot detect iconv
API

../configure --enable-iconv results in 
../meson.build:446:2: ERROR: Problem encountered: Cannot detect iconv
API

I haven't yet learned meson well enough to identify further what is
going wrong.

Can someone take a look at what might be failing, or give me some clue
what I can check on or report on from my end which would be helpful to
resolve this?
I am running openSUSE Tumbleweed, by the way.

Thanks,

Bruce


