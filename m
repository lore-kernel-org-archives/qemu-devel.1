Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625CFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BCF206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pGMuFC/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BCF206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhlV-0000de-6Y
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhgD-0001yf-Jc; Fri, 15 May 2020 17:15:41 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com
 ([40.107.20.100]:45280 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhgB-0005Vf-0c; Fri, 15 May 2020 17:15:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQv8hd4qCvdvLqd56EEoj2TfGEJ5vmejhGBXO67fn5eUCSL8F7jmbrPH4DpFXlP92deQE79HT2li4zPeP3KpNtVaMkir23zQjT8UIxIKrX01cVopV+/eRz6lwCUATemha0PJLtkM7P/+hHieXi/I6xn9RLNva0uxhjoqtw38cTj39E74s+shfGKvsXE+uyNnam/Pl7/vvcy+iHhxeuJYlphN1JxbVaDa5zy5rMoo87WLP1RO5jkOoUXs5oAXbqzo4zMKXE8afStiZbNOja/Eeod9aXp4lbTczJniUm6rI61Q2NifMpH+pyPi5ye1cnIq1Znt9YUZJl9ua340mPuzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2yXdkj+0//54LF0MTJq6iA1zXBGdsFd8BxYBrM+sis=;
 b=k27Q2CRRHXhbUw8EBG4T8vaEe0YJt6MUBsLi5kDMRpkIFAYVlAwzhEpX8E3pV7Pd3PYLlg3aMqPTWPVpWA2nXr9N3dAoiE/L7NidO0IOUnle6YT5E8p2l2Up8nI6uyxOz9zkV4d914888Fle2yindV3DB4cwQHBW/dTEXBin/ep9C/UhD4V8QCIgF7waaYru/G6zzamkLzoZ2FbCJUVZgWJkwp+ccLtIv5BhPZr0TvOGj0WmTiMluw4uyJ+emdUHEF2+XGLZTst0q7DcaR6YQW2fUOWw2ylcqxoUfHF4/IMS5jazTM6zSmHlGLmNhHvWG+9Ohvap7YewkHmUKnmLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2yXdkj+0//54LF0MTJq6iA1zXBGdsFd8BxYBrM+sis=;
 b=pGMuFC/wvawsMDSMr3GY6ImMEMFAoGdOYgrHKgpb0wEKL1x0qRM5NQf+0O1NkWHflc/mLywK1PrxIqauTGySPhbWb/aklW5MDN/anJ4yfG5bEGFnEdIoRuExvvWq/5X+0EoyfpUHbqoWu/d1oliAH41ILtJXdDzrfqMYrD1cK3w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 8/9] iotests: rewrite check into python
Date: Sat, 16 May 2020 00:15:04 +0300
Message-Id: <20200515211505.3042-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515211505.3042-1-vsementsov@virtuozzo.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:25 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35a0337c-dcc0-4c5f-f7f8-08d7f915164c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478A5BB921BEE8C5D456383C1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MkKdzThPp95RafaoW5vEGHkdzIoQrfrCwCpUW2kaICOZVWeXB3erykPi6+28rO+qxFGd+f//0gixqvePxolbQ02EWssXJpPrUCTg1YTlR3/gSTyoVOQvd4xEmwT7n+v9LX6izjJ8hpwmgCsj8EtQYH1aRGQBxMT+rSkvD8iHu8kJn6EfJZswJ4u9tl1XKjeDHY1Eo7FyCv5u3dAVaZK3Q7crwXo7H4Mo8W4fWmD2dmCy8QoLT3GgJK8iPIFo/jeisNQOtrTYrn8bGMAIur4AFx7mgdelBjUoeDJPcsJC9ceolY4ltBQUrNh6qsQGVfrH1dAuUNQGnU9/60QM+/8MbwUuV82ABehQoTLTXHHTsfIX3PyBxifk9E9+A6Td6SXemrr27vtsTD9793mx4lOIjnXyykamxHcnIi3bVPkAKoOqSsh37uQuksXeBZuQEsGTEMSuFxiNg6vOYHGoQjbTZZ2aNEJ+g7d9CBY6VTb1T50yY0I0NvXmSy1D1eXUw5gYICRhXg1s/uS4+BWc4U+Oo9lTrf20OqYI7vTd5mNe9S8xqg1avBJqENrZm/5ZYIY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(30864003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PE7+BK2kRd4EjC89G5YdIi6RXC51m/7vCGCiTHeP6PaEBSf3mwz6gbcUiNGmCRdHsQgMTVDiCe/qj/aIrEZhLh0cN/s/m8+cOd3BOAdbTlXCsoQHLh4qt8n5oEi8uKXuDPOu3xLNs2f66lBYm4vaGW406NDwH4niGOmRgEPc4m5U82bbOT/NP74XAK76fQPpStjYzHl6MCnBg5lJGuXh9z4mJsRStmYlvmDqa0gS/LvKjmlq68Um3k7ESuyMiSVoV8Bg8eujMTcubulUqw1oGRQnkLHcq0APfx7soeEQ5gjXThyhhg3eGwAH89JF4jvxTxdjF8j4hS63z7P0+llUw8DGFMfOFEX0QwbghCfkWWLnhETOGrFlaewEnCgEsKjsqTR9RMtGNQGtVeNw6y0jUEc3ED1VuIJm9WGQvWLxsxJh1YnQPtNMYYuJEayxRnUQ73/0p+FkHMQ8U7k4XNYViuHziQtiNYntjf2/iZhZRqY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a0337c-dcc0-4c5f-f7f8-08d7f915164c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:26.3272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BPYoW3o5D2zYDPjMbsQNkR4Ow/wagSj1Tq/uHzXow/aXR2D97yMDpAsWI0ScXfs/vV+YyseUO9ZxlwRPvcGq5o4PXpcw1LLQOx+W67dEwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.20.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:15:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just use classes introduced in previous three commits. Behavior
difference is described in these three commits.

Drop group file, as it becomes unused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/check | 983 ++-------------------------------------
 tests/qemu-iotests/group | 302 ------------
 2 files changed, 28 insertions(+), 1257 deletions(-)
 delete mode 100644 tests/qemu-iotests/group

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 9c461cf76d..48bb3128c3 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -1,7 +1,8 @@
-#!/usr/bin/env bash
+#!/usr/bin/env python3
 #
-# Copyright (C) 2009 Red Hat, Inc.
-# Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserved.
+# Configure environment and run group of tests in it.
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -14,956 +15,28 @@
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-#
-# Control script for QA
-#
-
-status=0
-needwrap=true
-try=0
-n_bad=0
-bad=""
-notrun=""
-casenotrun=""
-interrupt=true
-makecheck=false
-
-_init_error()
-{
-    echo "check: $1" >&2
-    exit 1
-}
-
-if [ -L "$0" ]
-then
-    # called from the build tree
-    source_iotests=$(dirname "$(readlink "$0")")
-    if [ -z "$source_iotests" ]
-    then
-        _init_error "failed to obtain source tree name from check symlink"
-    fi
-    source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
-    build_iotests=$PWD
-else
-    # called from the source tree
-    source_iotests=$PWD
-    # this may be an in-tree build (note that in the following code we may not
-    # assume that it truly is and have to test whether the build results
-    # actually exist)
-    build_iotests=$PWD
-fi
-
-build_root="$build_iotests/../.."
-
-# we need common.env
-if ! . "$build_iotests/common.env"
-then
-    _init_error "failed to source common.env (make sure the qemu-iotests are run from tests/qemu-iotests in the build tree)"
-fi
-
-# we need common.config
-if ! . "$source_iotests/common.config"
-then
-    _init_error "failed to source common.config"
-fi
-
-_full_imgfmt_details()
-{
-    if [ -n "$IMGOPTS" ]; then
-        echo "$IMGFMT ($IMGOPTS)"
-    else
-        echo "$IMGFMT"
-    fi
-}
-
-_full_platform_details()
-{
-    os=$(uname -s)
-    host=$(hostname -s)
-    kernel=$(uname -r)
-    platform=$(uname -m)
-    echo "$os/$platform $host $kernel"
-}
-
-_full_env_details()
-{
-    cat <<EOF
-QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
-QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
-QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
-QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
-IMGFMT        -- $FULL_IMGFMT_DETAILS
-IMGPROTO      -- $IMGPROTO
-PLATFORM      -- $FULL_HOST_DETAILS
-TEST_DIR      -- $TEST_DIR
-SOCK_DIR      -- $SOCK_DIR
-SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
-
-EOF
-}
-
-# $1 = prog to look for
-set_prog_path()
-{
-    p=$(command -v $1 2> /dev/null)
-    if [ -n "$p" -a -x "$p" ]; then
-        type -p "$p"
-    else
-        return 1
-    fi
-}
-
-if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=$PWD/scratch
-fi
-mkdir -p "$TEST_DIR" || _init_error 'Failed to create TEST_DIR'
-
-tmp_sock_dir=false
-if [ -z "$SOCK_DIR" ]; then
-    SOCK_DIR=$(mktemp -d)
-    tmp_sock_dir=true
-fi
-mkdir -p "$SOCK_DIR" || _init_error 'Failed to create SOCK_DIR'
-
-diff="diff -u"
-verbose=false
-debug=false
-group=false
-xgroup=false
-imgopts=false
-showme=false
-sortme=false
-expunge=true
-have_test_arg=false
-cachemode=false
-aiomode=false
-
-tmp="${TEST_DIR}"/$$
-rm -f $tmp.list $tmp.tmp $tmp.sed
-
-export IMGFMT=raw
-export IMGFMT_GENERIC=true
-export IMGPROTO=file
-export IMGOPTS=""
-export CACHEMODE="writeback"
-export AIOMODE="threads"
-export QEMU_IO_OPTIONS=""
-export QEMU_IO_OPTIONS_NO_FMT=""
-export CACHEMODE_IS_DEFAULT=true
-export VALGRIND_QEMU=
-export IMGKEYSECRET=
-export IMGOPTSSYNTAX=false
-
-# Save current tty settings, since an aborting qemu call may leave things
-# screwed up
-STTY_RESTORE=
-if test -t 0; then
-    STTY_RESTORE=$(stty -g)
-fi
-
-for r
-do
-
-    if $group
-    then
-        # arg after -g
-        group_list=$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
-s/ .*//p
-}')
-        if [ -z "$group_list" ]
-        then
-            echo "Group \"$r\" is empty or not defined?"
-            exit 1
-        fi
-        [ ! -s $tmp.list ] && touch $tmp.list
-        for t in $group_list
-        do
-            if grep -s "^$t\$" $tmp.list >/dev/null
-            then
-                :
-            else
-                echo "$t" >>$tmp.list
-            fi
-        done
-        group=false
-        continue
-
-    elif $xgroup
-    then
-        # arg after -x
-        # Populate $tmp.list with all tests
-        awk '/^[0-9]{3,}/ {print $1}' "${source_iotests}/group" > $tmp.list 2>/dev/null
-        group_list=$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
-s/ .*//p
-}')
-        if [ -z "$group_list" ]
-        then
-            echo "Group \"$r\" is empty or not defined?"
-            exit 1
-        fi
-        numsed=0
-        rm -f $tmp.sed
-        for t in $group_list
-        do
-            if [ $numsed -gt 100 ]
-            then
-                sed -f $tmp.sed <$tmp.list >$tmp.tmp
-                mv $tmp.tmp $tmp.list
-                numsed=0
-                rm -f $tmp.sed
-            fi
-            echo "/^$t\$/d" >>$tmp.sed
-            numsed=$(expr $numsed + 1)
-        done
-        sed -f $tmp.sed <$tmp.list >$tmp.tmp
-        mv $tmp.tmp $tmp.list
-        xgroup=false
-        continue
-
-    elif $imgopts
-    then
-        IMGOPTS="$r"
-        imgopts=false
-        continue
-    elif $cachemode
-    then
-        CACHEMODE="$r"
-        CACHEMODE_IS_DEFAULT=false
-        cachemode=false
-        continue
-    elif $aiomode
-    then
-        AIOMODE="$r"
-        aiomode=false
-        continue
-    fi
-
-    xpand=true
-    case "$r"
-    in
-
-        -\? | -h | --help)        # usage
-            echo "Usage: $0 [options] [testlist]"'
-
-common options
-    -v                  verbose
-    -d                  debug
-
-image format options
-    -raw                test raw (default)
-    -bochs              test bochs
-    -cloop              test cloop
-    -parallels          test parallels
-    -qcow               test qcow
-    -qcow2              test qcow2
-    -qed                test qed
-    -vdi                test vdi
-    -vpc                test vpc
-    -vhdx               test vhdx
-    -vmdk               test vmdk
-    -luks               test luks
-    -dmg                test dmg
-
-image protocol options
-    -file               test file (default)
-    -rbd                test rbd
-    -sheepdog           test sheepdog
-    -nbd                test nbd
-    -ssh                test ssh
-    -nfs                test nfs
-    -vxhs               test vxhs
-
-other options
-    -xdiff              graphical mode diff
-    -nocache            use O_DIRECT on backing file
-    -misalign           misalign memory allocations
-    -n                  show me, do not run tests
-    -o options          -o options to pass to qemu-img create/convert
-    -c mode             cache mode
-    -i mode             AIO mode
-    -makecheck          pretty print output for make check
-
-testlist options
-    -g group[,group...]        include tests from these groups
-    -x group[,group...]        exclude tests from these groups
-    NNN                        include test NNN
-    NNN-NNN                    include test range (eg. 012-021)
-'
-            exit 0
-            ;;
-
-        -raw)
-            IMGFMT=raw
-            xpand=false
-            ;;
-
-        -bochs)
-            IMGFMT=bochs
-            IMGFMT_GENERIC=false
-            xpand=false
-            ;;
-
-        -cloop)
-            IMGFMT=cloop
-            IMGFMT_GENERIC=false
-            xpand=false
-            ;;
-
-        -parallels)
-            IMGFMT=parallels
-            xpand=false
-            ;;
-
-        -qcow)
-            IMGFMT=qcow
-            xpand=false
-            ;;
-
-        -qcow2)
-            IMGFMT=qcow2
-            xpand=false
-            ;;
-
-        -luks)
-            IMGOPTSSYNTAX=true
-            IMGFMT=luks
-            IMGKEYSECRET=123456
-            xpand=false
-            ;;
-
-        -dmg)
-            IMGFMT=dmg
-            IMGFMT_GENERIC=false
-            xpand=false
-            ;;
-
-        -qed)
-            IMGFMT=qed
-            xpand=false
-            ;;
-
-        -vdi)
-            IMGFMT=vdi
-            xpand=false
-            ;;
-
-        -vmdk)
-            IMGFMT=vmdk
-            xpand=false
-            ;;
-
-        -vpc)
-            IMGFMT=vpc
-            xpand=false
-            ;;
-
-        -vhdx)
-            IMGFMT=vhdx
-            xpand=false
-            ;;
-
-        -file)
-            IMGPROTO=file
-            xpand=false
-            ;;
-
-        -rbd)
-            IMGPROTO=rbd
-            xpand=false
-            ;;
-
-        -sheepdog)
-            IMGPROTO=sheepdog
-            xpand=false
-            ;;
-
-        -nbd)
-            IMGPROTO=nbd
-            xpand=false
-            ;;
-
-        -vxhs)
-            IMGPROTO=vxhs
-            xpand=false
-            ;;
-
-        -ssh)
-            IMGPROTO=ssh
-            xpand=false
-            ;;
-
-        -nfs)
-            IMGPROTO=nfs
-            xpand=false
-            ;;
-
-        -nocache)
-            CACHEMODE="none"
-            CACHEMODE_IS_DEFAULT=false
-            xpand=false
-            ;;
-
-        -misalign)
-            QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --misalign"
-            xpand=false
-            ;;
-
-        -valgrind)
-            VALGRIND_QEMU='y'
-            xpand=false
-            ;;
-
-        -g)        # -g group ... pick from group file
-            group=true
-            xpand=false
-            ;;
-
-        -xdiff)        # graphical diff mode
-            xpand=false
-
-            if [ ! -z "$DISPLAY" ]
-            then
-                command -v xdiff >/dev/null 2>&1 && diff=xdiff
-                command -v gdiff >/dev/null 2>&1 && diff=gdiff
-                command -v tkdiff >/dev/null 2>&1 && diff=tkdiff
-                command -v xxdiff >/dev/null 2>&1 && diff=xxdiff
-            fi
-            ;;
-        -makecheck)   # makecheck friendly output
-            makecheck=true
-            xpand=false
-            ;;
-        -n)        # show me, don't do it
-            showme=true
-            xpand=false
-            ;;
-        -o)
-            imgopts=true
-            xpand=false
-            ;;
-        -c)
-            cachemode=true
-            xpand=false
-            ;;
-        -i)
-            aiomode=true
-            xpand=false
-            ;;
-        -T)        # deprecated timestamp option
-            xpand=false
-            ;;
-        -v)
-            verbose=true
-            xpand=false
-            ;;
-        -d)
-            debug=true
-            xpand=false
-            ;;
-        -x)        # -x group ... exclude from group file
-            xgroup=true
-            xpand=false
-            ;;
-        '[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
-            echo "No tests?"
-            status=1
-            exit $status
-            ;;
-
-        [0-9]*-[0-9]*)
-            eval $(echo $r | sed -e 's/^/start=/' -e 's/-/ end=/')
-            ;;
-
-        [0-9]*-)
-            eval $(echo $r | sed -e 's/^/start=/' -e 's/-//')
-            end=$(echo [0-9][0-9][0-9] [0-9][0-9][0-9][0-9] | sed -e 's/\[0-9]//g' -e 's/  *$//' -e 's/.* //')
-            if [ -z "$end" ]
-            then
-                echo "No tests in range \"$r\"?"
-                status=1
-                exit $status
-            fi
-            ;;
-
-        *)
-            start=$r
-            end=$r
-            ;;
-
-    esac
-
-    # get rid of leading 0s as can be interpreted as octal
-    start=$(echo $start | sed 's/^0*//')
-    end=$(echo $end | sed 's/^0*//')
-
-    if $xpand
-    then
-        have_test_arg=true
-        awk </dev/null '
-BEGIN        { for (t='$start'; t<='$end'; t++) printf "%03d\n",t }' \
-        | while read id
-        do
-            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/null
-            then
-                # in group file ... OK
-                echo $id >>$tmp.list
-            else
-                if [ -f expunged ] && $expunge && egrep "^$id([         ]|\$)" expunged >/dev/null
-                then
-                    # expunged ... will be reported, but not run, later
-                    echo $id >>$tmp.list
-                else
-                    # oops
-                    if [ "$start" == "$end" -a "$id" == "$end" ]
-                    then
-                        echo "$id - unknown test"
-                        exit 1
-                    else
-                        echo "$id - unknown test, ignored"
-                    fi
-                fi
-            fi
-        done || exit 1
-    fi
-
-done
-
-# Set qemu-io cache mode with $CACHEMODE we have
-QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --cache $CACHEMODE"
-# Set qemu-io aio mode with $AIOMODE we have
-QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --aio $AIOMODE"
-
-QEMU_IO_OPTIONS_NO_FMT="$QEMU_IO_OPTIONS"
-if [ "$IMGOPTSSYNTAX" != "true" ]; then
-    QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS -f $IMGFMT"
-fi
-
-# Set default options for qemu-img create -o if they were not specified
-if [ "$IMGFMT" == "qcow2" ] && ! (echo "$IMGOPTS" | grep "compat=" > /dev/null); then
-    IMGOPTS=$(_optstr_add "$IMGOPTS" "compat=1.1")
-fi
-if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null); then
-    IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
-fi
-if [ "$IMGFMT" == "vmdk" ] && ! (echo "$IMGOPTS" | grep "zeroed_grain=" > /dev/null); then
-    IMGOPTS=$(_optstr_add "$IMGOPTS" "zeroed_grain=on")
-fi
-
-if [ -z "$SAMPLE_IMG_DIR" ]; then
-        SAMPLE_IMG_DIR="$source_iotests/sample_images"
-fi
-
-export TEST_DIR
-export SOCK_DIR
-export SAMPLE_IMG_DIR
-
-if [ -s $tmp.list ]
-then
-    # found some valid test numbers ... this is good
-    :
-else
-    if $have_test_arg
-    then
-        # had test numbers, but none in group file ... do nothing
-        touch $tmp.list
-    else
-        # no test numbers, do everything from group file
-        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_iotests/group" >$tmp.list
-    fi
-fi
-
-# should be sort -n, but this did not work for Linux when this
-# was ported from IRIX
-#
-list=$(sort $tmp.list)
-rm -f $tmp.list $tmp.tmp $tmp.sed
-
-if [ -z "$QEMU_PROG" ]
-then
-    if [ -x "$build_iotests/qemu" ]; then
-        export QEMU_PROG="$build_iotests/qemu"
-    elif [ -x "$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}" ]; then
-        export QEMU_PROG="$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}"
-    else
-        pushd "$build_root" > /dev/null
-        for binary in *-softmmu/qemu-system-*
-        do
-            if [ -x "$binary" ]
-            then
-                export QEMU_PROG="$build_root/$binary"
-                break
-            fi
-        done
-        popd > /dev/null
-        [ "$QEMU_PROG" = "" ] && _init_error "qemu not found"
-    fi
-fi
-export QEMU_PROG="$(type -p "$QEMU_PROG")"
-
-case "$QEMU_PROG" in
-    *qemu-system-arm|*qemu-system-aarch64)
-        export QEMU_OPTIONS="-nodefaults -display none -machine virt -accel qtest"
-        ;;
-    *qemu-system-tricore)
-        export QEMU_OPTIONS="-nodefaults -display none -machine tricore_testboard -accel qtest"
-        ;;
-    *)
-        export QEMU_OPTIONS="-nodefaults -display none -accel qtest"
-        ;;
-esac
-
-if [ -z "$QEMU_IMG_PROG" ]; then
-    if [ -x "$build_iotests/qemu-img" ]; then
-        export QEMU_IMG_PROG="$build_iotests/qemu-img"
-    elif [ -x "$build_root/qemu-img" ]; then
-        export QEMU_IMG_PROG="$build_root/qemu-img"
-    else
-        _init_error "qemu-img not found"
-    fi
-fi
-export QEMU_IMG_PROG="$(type -p "$QEMU_IMG_PROG")"
-
-if [ -z "$QEMU_IO_PROG" ]; then
-    if [ -x "$build_iotests/qemu-io" ]; then
-        export QEMU_IO_PROG="$build_iotests/qemu-io"
-    elif [ -x "$build_root/qemu-io" ]; then
-        export QEMU_IO_PROG="$build_root/qemu-io"
-    else
-        _init_error "qemu-io not found"
-    fi
-fi
-export QEMU_IO_PROG="$(type -p "$QEMU_IO_PROG")"
-
-if [ -z $QEMU_NBD_PROG ]; then
-    if [ -x "$build_iotests/qemu-nbd" ]; then
-        export QEMU_NBD_PROG="$build_iotests/qemu-nbd"
-    elif [ -x "$build_root/qemu-nbd" ]; then
-        export QEMU_NBD_PROG="$build_root/qemu-nbd"
-    else
-        _init_error "qemu-nbd not found"
-    fi
-fi
-export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
-
-if [ -z "$QEMU_VXHS_PROG" ]; then
-    export QEMU_VXHS_PROG="$(set_prog_path qnio_server)"
-fi
-
-if [ -x "$build_iotests/socket_scm_helper" ]
-then
-    export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
-fi
-
-python_usable=false
-if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >= (3,6) else 1)'
-then
-    # Our python framework also requires virtio-blk
-    if "$QEMU_PROG" -M none -device help | grep -q virtio-blk >/dev/null 2>&1
-    then
-        python_usable=true
-    else
-        python_unusable_because="Missing virtio-blk in QEMU binary"
-    fi
-else
-    python_unusable_because="Unsupported Python version"
-fi
-
-default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
-default_alias_machine=$($QEMU_PROG -machine help | \
-   sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
-if [[ "$default_alias_machine" ]]; then
-    default_machine="$default_alias_machine"
-fi
-
-export QEMU_DEFAULT_MACHINE="$default_machine"
-
-TIMESTAMP_FILE=check.time-$IMGPROTO-$IMGFMT
-
-_wallclock()
-{
-    date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
-}
-
-_wrapup()
-{
-    if $showme
-    then
-        :
-    elif $needwrap
-    then
-        if [ -f $TIMESTAMP_FILE -a -f $tmp.time ]
-        then
-            cat $TIMESTAMP_FILE $tmp.time \
-            | awk '
-        { t[$1] = $2 }
-END        { if (NR > 0) {
-            for (i in t) print i " " t[i]
-          }
-        }' \
-            | sort -n >$tmp.out
-            mv $tmp.out $TIMESTAMP_FILE
-        fi
-
-        if [ -f $tmp.expunged ]
-        then
-            notrun=$(wc -l <$tmp.expunged | sed -e 's/  *//g')
-            try=$(expr $try - $notrun)
-            list=$(echo "$list" | sed -f $tmp.expunged)
-        fi
-
-        echo "" >>check.log
-        date >>check.log
-        echo $list | fmt | sed -e 's/^/    /' >>check.log
-        $interrupt && echo "Interrupted!" >>check.log
-
-        if [ ! -z "$notrun" ]
-        then
-            echo "Not run:$notrun"
-            echo "Not run:$notrun" >>check.log
-        fi
-        if [ ! -z "$casenotrun" ]
-        then
-            echo "Some cases not run in:$casenotrun"
-            echo "Some cases not run in:$casenotrun" >>check.log
-        fi
-        if [ ! -z "$n_bad" -a $n_bad != 0 ]
-        then
-            echo "Failures:$bad"
-            echo "Failed $n_bad of $try iotests"
-            echo "Failures:$bad" | fmt >>check.log
-            echo "Failed $n_bad of $try iotests" >>check.log
-        else
-            echo "Passed all $try iotests"
-            echo "Passed all $try iotests" >>check.log
-        fi
-        needwrap=false
-    fi
-
-    if test -n "$STTY_RESTORE"; then
-        stty $STTY_RESTORE
-    fi
-    rm -f "${TEST_DIR}"/*.out "${TEST_DIR}"/*.err "${TEST_DIR}"/*.time
-    rm -f "${TEST_DIR}"/check.pid "${TEST_DIR}"/check.sts
-    rm -f $tmp.*
-
-    if $tmp_sock_dir
-    then
-        rm -rf "$SOCK_DIR"
-    fi
-}
-
-trap "_wrapup; exit \$status" 0 1 2 3 15
-
-# Report the test start and results. For makecheck we want to pretty
-# print the whole report at the end of the execution.
-# args: $seq, $starttime, $lasttime
-_report_test_start()
-{
-    if ! $makecheck; then
-        if [ -n "$3" ]; then
-            local lasttime=" (last: $3s)"
-        fi
-        printf "%-8s %-10s [%s]            %4s%-14s\r" "$1" "..." "$2" "..." "$lasttime"
-    fi
-}
-# args:$seq $status $starttime $lasttime $thistime $details
-_report_test_result()
-{
-    local status lasttime thistime
-    if $makecheck; then
-        if [ -n "$2" ] && [ "$2" != "pass" ]; then
-            status=" [$2]"
-        fi
-        printf "  TEST    iotest-$IMGFMT: %s%s\n" "$1" "$status"
-        return
-    fi
-
-    if [ -n "$4" ]; then
-        lasttime=" (last: $4s)"
-    fi
-    if [ -n "$5" ]; then
-        thistime=" $5s"
-    fi
-    case "$2" in
-        "pass")     status=$(printf "\e[32m%-10s\e[0m" "$2") ;;
-        "fail")     status=$(printf "\e[1m\e[31m%-10s\e[0m" "$2") ;;
-        "not run")  status=$(printf "\e[33m%-10s\e[0m" "$2") ;;
-        *)          status=$(printf "%-10s" "$2") ;;
-    esac
-
-    printf "%-8s %s [%s] [%s] %4s%-14s %s\n" "$1" "$status" "$3" "$(date '+%T')" "$thistime" "$lasttime" "$6"
-}
-
-[ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
-
-FULL_IMGFMT_DETAILS=$(_full_imgfmt_details)
-FULL_HOST_DETAILS=$(_full_platform_details)
-
-if ! $makecheck; then
-    _full_env_details
-fi
-
-seq="check"
-
-[ -n "$TESTS_REMAINING_LOG" ] && echo $list > $TESTS_REMAINING_LOG
-
-for seq in $list
-do
-    err=false       # error flag
-    printdiff=false # show diff to reference output?
-    status=""       # test result summary
-    results=""      # test result details
-    thistime=""     # time the test took
-
-    if [ -n "$TESTS_REMAINING_LOG" ] ; then
-        sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
-        mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
-        sync
-    fi
-
-    lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
-    starttime=$(date "+%T")
-    _report_test_start $seq $starttime $lasttime
-
-    if $showme
-    then
-        status="not run"
-    elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" expunged >/dev/null
-    then
-        status="not run"
-        results="expunged"
-        rm -f $seq.out.bad
-        echo "/^$seq\$/d" >>$tmp.expunged
-    elif [ ! -f "$source_iotests/$seq" ]
-    then
-        status="not run"
-        results="no such test?"
-        echo "/^$seq\$/d" >>$tmp.expunged
-    else
-        # really going to try and run this one
-        #
-        rm -f $seq.out.bad
-        rm -f core $seq.notrun
-        rm -f $seq.casenotrun
-
-        start=$(_wallclock)
-
-        if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python3" ]; then
-            if $python_usable; then
-                run_command="$PYTHON $seq"
-            else
-                run_command="false"
-                echo "$python_unusable_because" > $seq.notrun
-            fi
-        else
-            run_command="./$seq"
-        fi
-        export OUTPUT_DIR=$PWD
-        if $debug; then
-            (cd "$source_iotests";
-            MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command -d 2>&1 | tee $tmp.out)
-        else
-            (cd "$source_iotests";
-            MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command >$tmp.out 2>&1)
-        fi
-        sts=$?
-        stop=$(_wallclock)
-
-        if [ -f core ]
-        then
-            mv core $seq.core
-            status="fail"
-            results="[dumped core] $seq.core"
-            err=true
-        fi
-
-        if [ -f $seq.notrun ]
-        then
-            # overwrites timestamp output
-            status="not run"
-            results="$(cat $seq.notrun)"
-        else
-            if [ $sts -ne 0 ]
-            then
-                status="fail"
-                results=$(printf %s "[failed, exit status $sts]")
-                err=true
-            fi
-
-            reference="$source_iotests/$seq.out"
-            reference_machine="$source_iotests/$seq.$QEMU_DEFAULT_MACHINE.out"
-            if [ -f "$reference_machine" ]; then
-                reference="$reference_machine"
-            fi
-
-            reference_format="$source_iotests/$seq.out.$IMGFMT"
-            if [ -f "$reference_format" ]; then
-                reference="$reference_format"
-            fi
-
-            if [ "$CACHEMODE" = "none" ]; then
-                [ -f "$source_iotests/$seq.out.nocache" ] && reference="$source_iotests/$seq.out.nocache"
-            fi
-
-            if [ ! -f "$reference" ]
-            then
-                status="fail"
-                results="no qualified output"
-                err=true
-            else
-                if diff -w "$reference" $tmp.out >/dev/null 2>&1
-                then
-                    if ! $err; then
-                        status="pass"
-                        thistime=$(expr $stop - $start)
-                        echo "$seq $thistime" >>$tmp.time
-                    fi
-                else
-                    mv $tmp.out $seq.out.bad
-                    status="fail"
-                    results="output mismatch (see $seq.out.bad)"
-                    printdiff=true
-                    err=true
-                fi
-            fi
-        fi
-        if [ -f $seq.casenotrun ]
-        then
-            cat $seq.casenotrun
-            casenotrun="$casenotrun $seq"
-        fi
-    fi
-
-    # come here for each test, except when $showme is true
-    #
-    _report_test_result $seq "$status" "$starttime" "$lasttime" "$thistime" "$results"
-    case "$status" in
-        "pass")
-            try=$(expr $try + 1)
-            ;;
-        "fail")
-            try=$(expr $try + 1)
-            if $makecheck; then
-                _full_env_details
-            fi
-            if $printdiff; then
-                $diff -w "$reference" "$PWD"/$seq.out.bad
-            fi
-            bad="$bad $seq"
-            n_bad=$(expr $n_bad + 1)
-            quick=false
-            ;;
-        "not run")
-            notrun="$notrun $seq"
-            ;;
-    esac
-
-    seq="after_$seq"
-done
 
-interrupt=false
-status=$(expr $n_bad)
-exit
+import sys
+import os
+from findtests import find_tests, TestFinder
+from testenv import TestEnv
+from testrunner import TestRunner
+
+if __name__ == '__main__':
+    if len(sys.argv) == 2 and sys.argv[1] in ['-h', '--help']:
+        print('Usage: ./check [options] [testlist]')
+        print()
+        TestFinder.get_argparser().print_help()
+        print()
+        TestEnv.get_argparser().print_help()
+        print()
+        TestRunner.get_argparser().print_help()
+        exit()
+
+    env = TestEnv(sys.argv[1:])
+    tests, remaining_argv = find_tests(env.remaining_argv,
+                                       test_dir=env.source_iotests)
+
+    with TestRunner(remaining_argv, env) as tr:
+        assert not tr.remaining_argv
+        tr.run_tests([os.path.join(env.source_iotests, t) for t in tests])
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
deleted file mode 100644
index 34175fd437..0000000000
--- a/tests/qemu-iotests/group
+++ /dev/null
@@ -1,302 +0,0 @@
-#
-# QA groups control file
-# Defines test groups
-#
-# Some notes about the groups:
-#
-# - do not start group names with a digit
-#
-# - quick : Tests in this group should finish within some few seconds.
-#
-# - img : Tests in this group can be used to excercise the qemu-img tool.
-#
-# - auto : Tests in this group are used during "make check" and should be
-#   runnable in any case. That means they should run with every QEMU binary
-#   (also non-x86), with every QEMU configuration (i.e. must not fail if
-#   an optional feature is not compiled in - but reporting a "skip" is ok),
-#   work at least with the qcow2 file format, work with all kind of host
-#   filesystems and users (e.g. "nobody" or "root") and must not take too
-#   much memory and disk space (since CI pipelines tend to fail otherwise).
-#
-
-#
-# test-group association ... one line per test
-#
-001 rw auto quick
-002 rw auto quick
-003 rw auto
-004 rw auto quick
-005 img auto quick
-# 006 was removed, do not reuse
-007 snapshot auto
-008 rw auto quick
-009 rw auto quick
-010 rw auto quick
-011 rw auto quick
-012 auto quick
-013 rw auto
-014 rw
-015 rw snapshot
-# 016 was removed, do not reuse
-017 rw backing auto quick
-018 rw backing auto quick
-019 rw backing auto quick
-020 rw backing auto quick
-021 io auto quick
-022 rw snapshot auto
-023 rw
-024 rw backing auto quick
-025 rw auto quick
-026 rw blkdbg
-027 rw auto quick
-028 rw backing quick
-029 rw auto quick
-030 rw auto backing
-031 rw auto quick
-032 rw auto quick
-033 rw auto quick
-034 rw auto backing quick
-035 rw auto quick
-036 rw auto quick
-037 rw auto backing quick
-038 rw auto backing quick
-039 rw auto quick
-040 rw auto
-041 rw auto backing
-042 rw auto quick
-043 rw auto backing
-044 rw
-045 rw quick
-046 rw auto aio quick
-047 rw auto quick
-048 img auto quick
-049 rw auto
-050 rw auto backing quick
-051 rw
-052 rw auto backing quick
-053 rw auto quick
-054 rw auto quick
-055 rw
-056 rw backing
-057 rw
-058 rw quick
-059 rw quick
-060 rw auto quick
-061 rw auto
-062 rw auto quick
-063 rw auto quick
-064 rw quick
-065 rw quick
-066 rw auto quick
-067 rw quick
-068 rw quick
-069 rw auto quick
-070 rw quick
-071 rw auto quick
-072 rw auto quick
-073 rw auto quick
-074 rw auto quick
-075 rw quick
-076 io
-077 rw quick
-078 rw quick
-079 rw auto
-080 rw auto
-081 rw quick
-082 rw quick
-083 rw
-084 img quick
-085 rw
-086 rw auto quick
-087 rw quick
-088 rw quick
-089 rw auto quick
-090 rw auto quick
-091 rw migration
-092 rw quick
-093 throttle
-094 rw quick
-095 rw quick
-096 rw quick
-097 rw auto backing
-098 rw auto backing quick
-099 rw auto quick
-# 100 was removed, do not reuse
-101 rw quick
-102 rw quick
-103 rw auto quick
-104 rw auto
-105 rw auto quick
-106 rw quick
-107 rw auto quick
-108 rw auto quick
-109 rw
-110 rw auto backing quick
-111 rw auto quick
-112 rw
-113 rw quick
-114 rw auto quick
-115 rw
-116 rw quick
-117 rw auto
-118 rw
-119 rw quick
-120 rw auto quick
-121 rw
-122 rw
-123 rw quick
-124 rw backing
-125 rw
-126 rw auto backing
-127 rw auto backing quick
-128 rw quick
-129 rw quick
-130 rw quick
-131 rw quick
-132 rw quick
-133 auto quick
-134 rw auto quick
-135 rw
-136 rw
-137 rw auto
-138 rw auto quick
-139 rw quick
-140 rw auto quick
-141 rw auto quick
-142
-143 auto quick
-144 rw quick
-145 quick
-146 quick
-147 img
-148 rw quick
-149 rw sudo
-150 rw auto quick
-151 rw
-152 rw quick
-153 rw quick
-154 rw auto backing quick
-155 rw
-156 rw auto quick
-157 quick
-158 rw auto quick
-159 rw auto quick
-160 rw quick
-161 rw auto quick
-162 quick
-163 rw
-165 rw quick
-169 rw quick migration
-170 rw auto quick
-171 rw quick
-172 auto
-173 rw
-174 auto
-175 quick
-176 rw auto backing
-177 rw auto quick
-178 img
-179 rw auto quick
-181 rw auto migration
-182 rw quick
-183 rw migration
-184 rw auto quick
-185 rw
-186 rw auto
-187 rw auto
-188 rw quick
-189 rw
-190 rw auto quick
-191 rw auto
-192 rw auto quick
-194 rw migration quick
-195 rw auto quick
-196 rw quick migration
-197 rw quick
-198 rw
-199 rw migration
-200 rw
-201 rw migration
-202 rw quick
-203 rw auto migration
-204 rw quick
-205 rw quick
-206 rw
-207 rw
-208 rw quick
-209 rw quick
-210 rw
-211 rw quick
-212 rw quick
-213 rw quick
-214 rw auto
-215 rw quick
-216 rw quick
-217 rw auto quick
-218 rw quick
-219 rw
-220 rw auto
-221 rw quick
-222 rw quick
-223 rw quick
-224 rw quick
-225 rw quick
-226 auto quick
-227 quick
-228 rw quick
-229 auto quick
-231 quick
-232 quick
-233 quick
-234 quick migration
-235 quick
-236 quick
-237 rw quick
-238 quick
-239 rw quick
-240 quick
-241 rw quick
-242 rw quick
-243 rw quick
-244 rw auto quick
-245 rw
-246 rw quick
-247 rw quick
-248 rw quick
-249 rw auto quick
-250 rw quick
-251 rw auto quick
-252 rw auto backing quick
-253 rw quick
-254 rw backing quick
-255 rw quick
-256 rw auto quick
-257 rw
-258 rw quick
-259 rw auto quick
-260 rw quick
-261 rw
-262 rw quick migration
-263 rw quick
-264 rw
-265 rw auto quick
-266 rw quick
-267 rw auto quick snapshot
-268 rw auto quick
-270 rw backing quick
-272 rw
-273 backing quick
-274 rw backing
-277 rw quick
-279 rw backing quick
-280 rw migration quick
-281 rw quick
-282 rw img quick
-283 auto quick
-284 rw
-286 rw quick
-287 auto quick
-288 quick
-289 rw quick
-290 rw auto quick
-292 rw auto quick
-- 
2.21.0


